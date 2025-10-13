<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use App\Models\Facility;
use Inertia\Inertia;
use App\Models\QualityControl;
use App\Models\AuditQuestion;
use App\Models\Department;
use App\Models\User;
use App\Models\SelectedChecklistQuestion;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Mail;
use setasign\Fpdi\Fpdi;
use setasign\Fpdf\Fpdf;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use Illuminate\Support\Facades\Auth;


class QualityControlController extends Controller implements HasMiddleware
{
    
    public static function middleware():array {
        return [
            new Middleware('permission:manage quality controls', 
            only: [
                'index','create','store','edit','update','show','destroy',
                'saveQuestionResponse',
                'listAudits','listInspections',
                'listSecurityTests','listPending',
                'listInProgress','listCompleted',
                'listOverdue',
                'approveChecklist',
                'exportPDF',

            ]),
        ];
    }

    public function index(Request $request)
    {
        $user = Auth::user();
        // Fetch all facilities from the database
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        
        if ($user->hasAnyRole(['Administrator', 'AVSEC Administrator', 'Super Admin'])) {
            // Admin can see all quality controls            
        }else {
           // For non-admins (e.g., AVSEC Inspectors), show only QualityControls linked via the pivot table
            $searchQuery->whereHas('users', function ($query) use ($user) {
                $query->where('users.id', $user->id)
                    ->where('approval_status', 'Approved');
            });
        }

        $qualityControls =  $searchQuery->orderBy('created_at','desc')->paginate(100);
        // Return the facilities to the view
        return Inertia::render('QualityControls/List', [
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function create()
    {
        //Get all quality control types from the QualityControl model
        $qualityControlTypes = QualityControl::CONTROL_TYPE;
        //Get all the facilities from the Facility model
        $facilities = Facility::all();
        $departments = Department::all();

        return inertia('QualityControls/Create',
        [
            'facilities' => $facilities,
            'qualityControlTypes' => $qualityControlTypes,
            'departments' => $departments,
        ]);
    }

    //Update the create method to include the facility_id and control_type
    public function edit($id)
    {
        //Get the users that have user_type of Inspector
        $qualityControl = QualityControl::with('facility')->findOrFail($id);   
        //Get all users with user_type of Inspector
        $users = User::where('user_type', 'CAA Staff')->select('id','name','portrait')->get();
        //Get the users that have been assigned to this quality control

        $hasAssignedUsers = $qualityControl->users->pluck('id'); 

        //Get the users that have been assigned as approvers to this quality control

        $hasApproverUsers = $qualityControl->approvers->pluck('id');

        $departments = Department::all(); 

        //Get all quality control types from the QualityControl model        
        $qualityControlTypes = QualityControl::CONTROL_TYPE;
        //Get all the facilities from the Facility model
        $facilities = Facility::all();
        //Find the quality control record by id
        
        $auditQuestions = AuditQuestion::with('auditAreaCategory')->orderBy('audit_area_category_id','ASC')->get(); 
        $hasChecklistQuestions = $qualityControl->selectedChecklistQuestions->pluck('audit_question_id');      
        $groupedAuditQuestions = $auditQuestions->groupBy('audit_area_name');
          
        return inertia('QualityControls/Edit',
        [
            'facilities' => $facilities,
            'qualityControlTypes' => $qualityControlTypes,
            'qualityControl' => $qualityControl,
            'hasChecklistQuestions' => $hasChecklistQuestions,
            'auditQuestions' => $auditQuestions,
            'groupedAuditQuestions' => $groupedAuditQuestions,
            'users' => $users,
            'hasAssignedUsers' => $hasAssignedUsers, 
            'hasApproverUsers' => $hasApproverUsers,
            'departments' => $departments,            
        ]);
    }

    public function update(Request $request, $id){
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'facility_id' => 'required|exists:facilities,id',
            'control_type' => 'required|string|in:' . implode(',', QualityControl::CONTROL_TYPE),            
            'description' => 'nullable|string|max:1000',
            'scheduled_date' => 'required|date',  
            'end_date' => 'nullable|date|after_or_equal:scheduled_date', // Ensure end_date is after or equal to scheduled_date
            'status' =>'required|string|max:60|in:Pending,In Progress,Completed,Overdue',

        ]);        
        
        // Check if validation passes
        if ($validator->passes()) {
            // Find the quality control record by id
            $qualityControl = QualityControl::findOrFail($id);
            // Update the quality control record            
            $qualityControl->update([
                'title' => $request->title,
                'facility_id' => $request->facility_id,
                'department_id' => $request->department_id,                
                'control_type' => $request->control_type,
                'description' => $request->description,
                'status' => $request->status, 
                'scheduled_date' => $request->scheduled_date,  
                'end_date' => $request->end_date, 
            ]);   

            if (!empty($request->selectedCheckListQuestions)) {
                foreach ($request->selectedCheckListQuestions as $questionId) {
                    $questionItem = AuditQuestion::find($questionId);                    
                    if ($questionItem) {
                        // Check if this checklist question already exists for this QC
                        $alreadyExists = SelectedChecklistQuestion::where('quality_control_id', $qualityControl->id)
                            ->where('question', $questionItem->question)
                            ->exists();

                        if (!$alreadyExists) {
                            SelectedChecklistQuestion::create([
                                'question' => $questionItem->question,
                                'audit_question_id' => $questionItem->id,
                                'audit_area_name' => $questionItem->audit_area_name,
                                'quality_control_id' => $qualityControl->id,
                                'reference' => $questionItem->reference,                                
                                'risk_description' => $questionItem->risk_description,
                            ]);
                        }
                    }
                }            
                // Delete any that are no longer selected
                SelectedChecklistQuestion::where('quality_control_id', $qualityControl->id)
                    ->whereNotIn('question', AuditQuestion::whereIn('id', $request->selectedCheckListQuestions)->pluck('question'))
                    ->delete();
            } else {
                // If no checklist questions selected, remove existing ones for this quality control
                SelectedChecklistQuestion::where('quality_control_id', $qualityControl->id)->delete();
            } 
            
            // Update the users assigned to this quality control
            if (!empty($request->selectedUsers)) {
                $qualityControl->users()->sync($request->selectedUsers);                      
            } else {
                // If no users assigned, detach all users
                $qualityControl->users()->detach();
            }

            if(!empty($request->selectedApproverUsers)){
                $qualityControl->approvers()->sync($request->selectedApproverUsers);
                foreach($request->selectedApproverUsers as $userId){
                    $user = User::find($userId);
                    if($user){
                        //Send email to the user
                        Mail::to($user->email)->send(new \App\Mail\notifyApprovingInspectors($user));
                    }
                }  
            }else{
                $qualityControl->approvers()->detach();
            }
            return redirect()->route('quality-controls.index')->with('success', 'Quality Control updated successfully.');
        }
        return response()->json(['errors' => $validator->errors()], 422);
    }

    public function show($id)
    {    
        //Find the quality control record by id
        $qualityControl = QualityControl::with('facility')->findOrFail($id);  
        
        //Check if the quality control has users assigned to it
        if ($qualityControl->users->isEmpty()) {
            return redirect()->route('errors')->with('error', 'No user was assigned to carry out this quality control.');
        }

        if($qualityControl->selectedChecklistQuestions->isEmpty()){
            // Check if the quality control has selected checklist questions
            return redirect()->route('errors')->with('error', 'No checklist questions were selected for this quality control activity.');            
        }

        $groupedCheckListQuestions = $qualityControl->selectedChecklistQuestions->groupBy('audit_area_name');                           
        return inertia('QualityControls/Show',
        [          
            'qualityControl' => $qualityControl,
            'groupedCheckListQuestions' => $groupedCheckListQuestions,                        
        ]);
    }

    public function destroy($id)
    {
        // Find the quality control record by id
        $qualityControl = QualityControl::find($id);        
        if (!$qualityControl || $qualityControl->id != $id) {
            return response()->json(['error' => 'Quality Control not found'], 404);
        }
        // Delete the quality control record
        $qualityControl->delete();
        // Redirect to the quality controls list with a success message
        return response()->json(
            ['success' => 'Quality Control deleted successfully.',
            'status' => true
            ], 
            200
        );        
    }

    public function store(Request $request)
    {
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'facility_id' => 'required|exists:facilities,id',
            'control_type' => 'required|string|in:' . implode(',', QualityControl::CONTROL_TYPE),            
            'description' => 'nullable|string|max:1000',
            'scheduled_date' => 'required|date|after_or_equal:today',  
            'end_date' => 'nullable|date|after_or_equal:scheduled_date',       
            'status' =>'required|string|max:60|in:Pending,In Progress,Completed,Overdue',
        ]);
        

        // Check if validation passes
        if ($validator->passes()) {
            // Create a new quality control record
            QualityControl::create([
                'title' => $request->title,
                'department_id' => $request->department_id,                
                 // Include department_id if needed
                'status' => 'Pending',
                'facility_id' => $request->facility_id,
                'control_type' => $request->control_type,
                'description' => $request->description,
                'scheduled_date' => $request->scheduled_date,    
                'end_date' => $request->end_date, // Update end_date if provided            
            ]);                       
            return redirect()->route('quality-controls.index')->with('success', 'Quality Control created successfully.');
        }
        return response()->json(['errors' => $validator->errors()], 422);
    }

    // public function saveQuestionResponse(Request $request,string $id){
    //     $validator = Validator::make($request->all(),[
    //         'question_id' => 'required|integer',
    //         'quality_control_id' => 'required|integer',
    //         'question_response' => 'required|string|in:Yes,No,Pass,Fail,Not Applicable,Not confirmed',
    //         'finding_observation' => 'required|string',
    //         'action_taken' => 'nullable|string',
    //         'immediate_corrective_action' => 'nullable|string',
    //         'recommendations' => 'nullable|string',
    //         'reference' => 'nullable|string',
    //         'status' => 'required|string|in:Open,Closed,Overdue',
    //         'finding_category' => 'required|string|in:Compliant,Not Compliant(Minor),Not Compliant(Serious),Not Applicable,Not Confirmed,Not Applicable,Not Confirmed',
    //         'date_quality_control' => 'required|date',
    //         'problem_cause' => 'nullable|string',
    //         'proposed_follow_up_action' => 'nullable|string|in:Onsite,Administrative,Onsite and Administrative,Not Applicable',
    //         'short_term_action' => 'nullable|string',
    //         'short_term_date' => 'nullable|date',
    //         'long_term_action' => 'nullable|string',
    //         'long_term_date' => 'nullable|date',
    //         'completion_date' => 'nullable|date',
    //         'date_of_closure' => 'nullable|date',
    //         'follow_up_date' => 'nullable|date',
    //         'evidence_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', 
    //     ]);

    //     if($validator->fails()){
    //         return response()->json(['errors' => $validator->errors()], 422);
    //     }

    //     $selectedCheckliskQuestion = SelectedChecklistQuestion::findOrFail($request->question_id);
    //     $selectedCheckliskQuestion->update([                    
    //         'question_response' => $request->question_response,
    //         'finding_observation' => $request->finding_observation,
    //         'action_taken' => $request->action_taken,
    //         'status' => $request->status,
    //         'finding_category' => $request->finding_category,
    //         'date_quality_control' => $request->date_quality_control,
    //         'problem_cause' =>$request->problem_cause,
    //         'proposed_follow_up_action' => $request->proposed_follow_up_action,
    //         'short_term_action' => $request->short_term_action,
    //         'long_term_action' => $request->long_term_action,
    //         'completion_date' => $request->completion_date,
    //         'date_of_closure' => $request->date_of_closure,
    //         'follow_up_date' => $request->follow_up_date,
    //         'immediate_corrective_action' => $request->immediate_corrective_action,
    //         'recommendations' => $request->recommendations,
    //         'reference' => $request->reference,
    //         'short_term_date' => $request->short_term_date,
    //         'long_term_date' => $request->long_term_date,

    //     ]);

    //     if ($request->hasFile('evidence_file')) {
    //         // Delete old file if exists
    //         if ($selectedCheckliskQuestion->evidence_file) {
    //             Storage::disk('public')->delete($selectedCheckliskQuestion->evidence_file);
    //         }
    //         $selectedCheckliskQuestion->evidence_file = $request->file('evidence_file')->store('qc_evidences', 'public');
    //     }
        
    //     $selectedCheckliskQuestion->save();
    //     return redirect()->route('quality-controls.show',$request->quality_control_id)->with('success', 'Checklist updated successfully.');        
    // }

   
    public function saveQuestionResponse(Request $request, string $id)
    {
        // Validation
        $validator = Validator::make($request->all(), [
            'question_id' => 'required|integer',
            'quality_control_id' => 'required|integer',
            'question_response' => 'required|string|in:Yes,No,Pass,Fail,Not Applicable,Not Confirmed',
            'finding_observation' => 'required|string',
            'action_taken' => 'nullable|string',
            'immediate_corrective_action' => 'nullable|string',
            'recommendations' => 'nullable|string',
            'reference' => 'nullable|string',            
            'status' => 'required|string|in:Open,Closed,Overdue',
            'finding_category' => 'required|string|in:Compliant,Not Compliant(Minor),Not Compliant(Serious),Not Applicable,Not Confirmed',
            'date_quality_control' => 'required|date',
            'problem_cause' => 'nullable|string',
            'proposed_follow_up_action' => 'nullable|string|in:Onsite,Administrative,Onsite and Administrative,Not Applicable',
            'short_term_action' => 'nullable|string',
            'short_term_date' => 'nullable|date',
            'long_term_action' => 'nullable|string',
            'long_term_date' => 'nullable|date',
            'completion_date' => 'nullable|date',
            'date_of_closure' => 'nullable|date',
            'follow_up_date' => 'nullable|date',
            'evidence_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048',
            'captured_image_file' => 'nullable|file|mimes:jpg,jpeg,png|max:2048', // single file
            'risk_description' => 'nullable|string',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Find the question
        $question = SelectedChecklistQuestion::findOrFail($request->question_id);

        // Prepare data for update
        $data = $request->only([
            'question_response',
            'finding_observation',
            'action_taken',
            'status',
            'finding_category',
            'date_quality_control',
            'problem_cause',
            'proposed_follow_up_action',
            'short_term_action',
            'long_term_action',
            'completion_date',
            'date_of_closure',
            'follow_up_date',
            'immediate_corrective_action',
            'recommendations',
            'reference',
            'short_term_date',
            'long_term_date',
            'risk_description',
        ]);

        // Handle evidence_file (single file)
        if ($request->hasFile('evidence_file')) {
            if ($question->evidence_file) {
                Storage::disk('public')->delete($question->evidence_file);
            }
            $data['evidence_file'] = $request->file('evidence_file')->store('qc_evidences', 'public');
        }

        // Handle captured_image_file (single file)
        if ($request->hasFile('captured_image_file')) {
            // Delete existing file if exists
            if (!empty($question->captured_image_file)) {
                $existingFile = json_decode($question->captured_image_file, true);
                if ($existingFile) {
                    Storage::disk('public')->delete($existingFile);
                }
            }
            // Store new file
            $filePath = $request->file('captured_image_file')->store('qc_captures', 'public');

            // Save as JSON
            $data['captured_image_file'] = json_encode($filePath);
        }

        // Update the question
        $question->update($data);

        return redirect()
            ->route('quality-controls.show', $request->quality_control_id)
            ->with('success', 'Checklist updated successfully.');
    }

    public function listAudits(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls = $searchQuery->where('control_type','Audit')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/Audits',[
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function listInspections(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls = $searchQuery->where('control_type','Inspection')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/Inspections',[
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function listSecurityTests(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls = $searchQuery->where('control_type','Security Test')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/SecurityTest',[
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function listPending(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls =  $searchQuery->where('status','Pending')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/Pending',[            
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function listInProgress(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls =  $searchQuery->where('status','In Progress')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/InProgress',[            
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function listCompleted(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls = $searchQuery->where('status','Completed')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/Completed',[
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function listOverdue(Request $request){
        $searchQuery = QualityControl::with(['facility','users','selectedChecklistQuestions'])->search($request);
        $qualityControls = $searchQuery->where('status','Overdue')->orderBy('created_at','desc')->paginate(50);
        return inertia('QualityControls/Overdue',[
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }    

    public function exportPDF($id)
    {
        $qualityControl = QualityControl::with(['facility', 'selectedchecklistQuestions'])->findOrFail($id);

        $questions = $qualityControl->selectedchecklistQuestions->map(function ($q) {
            return [
                'id' => $q->id,
                'audit_area_name' => $q->audit_area_name,
                'question' => $q->question,
                'question_response' => $q->question_response ?? 'N/A',
                'finding_observation' => $q->finding_observation ?? 'N/A',
                'finding_category' => $q->finding_category ?? 'N/A',
                'date_quality_control' => $q->date_quality_control ?? 'N/A',
                'status' => $q->status ?? 'N/A',
                'evidence_file' => $q->evidence_file ?? null,
                //'immediate_corrective_action' => $q->immediate_corrective_action ?? 'N/A',
                // 'recommendations' => $q->recommendations ?? 'N/A',
                // 'reference' => $q->reference ?? 'N/A',
                //'proposed_follow_up_action' => $q->proposed_follow_up_action ?? 'N/A',
            ];
        });

        // 1️Generate main QC PDF
        $pdf = Pdf::loadView('pdfTemplates.selectedQualityControls', [
            'qualityControl' => $qualityControl,
            'questions' => $questions
        ])->setPaper('a4', 'portrait');//portrait
        // ->setPaper('a4', 'landscape');

        $mainPdfPath = storage_path("app/public/temp_qc_{$qualityControl->id}.pdf");
        $pdf->save($mainPdfPath);

        // 2 Merge PDFs with FPDI
        $fpdi = new Fpdi();

        // Add main PDF
        $pageCount = $fpdi->setSourceFile($mainPdfPath);
        for ($pageNo = 1; $pageNo <= $pageCount; $pageNo++) {
            $tplId = $fpdi->importPage($pageNo);
            $size = $fpdi->getTemplateSize($tplId);
            $fpdi->AddPage($size['orientation'], [$size['width'], $size['height']]);
            $fpdi->useTemplate($tplId);
        }

        // Add evidence PDFs
        foreach ($qualityControl->selectedchecklistQuestions as $q) {
            if ($q->evidence_file && Storage::disk('public')->exists($q->evidence_file)) {
                $evidencePath = storage_path("app/public/{$q->evidence_file}");
                if (strtolower(pathinfo($evidencePath, PATHINFO_EXTENSION)) === 'pdf') {
                    $pageCount = $fpdi->setSourceFile($evidencePath);
                    for ($pageNo = 1; $pageNo <= $pageCount; $pageNo++) {
                        $tplId = $fpdi->importPage($pageNo);
                        $size = $fpdi->getTemplateSize($tplId);
                        $fpdi->AddPage($size['orientation'], [$size['width'], $size['height']]);
                        $fpdi->useTemplate($tplId);
                    }
                }
            }
        }

        $outputFileName = 'QualityControl_' . $qualityControl->id . '.pdf';
        return response()->streamDownload(function () use ($fpdi) {
            $fpdi->Output('F', 'php://output');
        }, $outputFileName);
    }

    public function approveQualityControl($id){
        $user = Auth::user();
        $qualityControl = QualityControl::findOrFail($id);
        $qualityControl->approval_status = 'Approved';
        $qualityControl->approved_by = $user->name;
        $qualityControl->approved_at = now();
        $qualityControl->save();
        if (!empty($qualityControl->users)) {            
            //send email to the users assigned to this quality control      
            foreach($qualityControl->users as $user){             
                if($user){
                    //Send email to the user
                    Mail::to($user->email)->send(new \App\Mail\notify_assigned_inspectors($user));
                }
            } 
        }else{            
            return redirect()->json('errors')->with('error', 'No user was assigned to carry out this quality control.', 422);
        }   
        return redirect()->route('quality-controls.show', $id)->with('success', 'Quality Control checklist approved successfully.');
    }


}

