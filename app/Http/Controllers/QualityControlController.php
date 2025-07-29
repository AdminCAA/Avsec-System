<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use App\Models\Facility;
use Inertia\Inertia;
use App\Models\QualityControl;
use App\Models\AuditQuestion;
use App\Models\User;
use App\Models\SelectedChecklistQuestion;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;


class QualityControlController extends Controller
{
    //
    public function index(Request $request)
    {
        // Fetch all facilities from the database
        $searchQuery = QualityControl::with(['facility','users'])->search($request);
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

        return inertia('QualityControls/Create',
        [
            'facilities' => $facilities,
            'qualityControlTypes' => $qualityControlTypes,
        ]);
    }

    //Update the create method to include the facility_id and control_type
    public function edit($id)
    {
        //Get the users that have user_type of Inspector
        $qualityControl = QualityControl::with('facility')->findOrFail($id);   
        //Get all users with user_type of Inspector
        $users = User::where('user_type', 'Inspector')->select('id', 'name', 'portrait')->get();
        //Get the users that have been assigned to this quality control
        $hasAssignedUsers = $qualityControl->users->pluck('id');  

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
                'control_type' => $request->control_type,
                'description' => $request->description,
                'scheduled_date' => $request->scheduled_date,  
                'end_date' => $request->end_date, // Update end_date if provided 

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
            return response()->json(['error' => 'Facility not found'], 404);
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


    public function saveQuestionResponse(Request $request,string $id){
        $validator = Validator::make($request->all(),[
            'question_id' => 'required|integer',
            'quality_control_id' => 'required|integer',
            'question_response' => 'required|string|in:Yes,No,Pass,Fail,Not Applicable,Not confirmed',
            'finding_observation' => 'nullable|string',
            'action_taken' => 'nullable|string',
            'immediate_corrective_action' => 'nullable|string',
            'recommendations' => 'nullable|string',
            'reference' => 'nullable|string',
            'status' => 'required|string|in:Open,Closed,Overdue',
            'finding_category' => 'required|string|in:Compliant,Not Compliant(Minor),Not Compliant(Serious),Not Applicable,Not Confirmed,Not Applicable,Not Confirmed',
            'date_quality_control' => 'required|date',
            'problem_cause' => 'nullable|string',
            'proposed_follow_up_action' => 'nullable|string|in:Onsite,Administrative,Onsite and Administrative',
            'short_term_action' => 'nullable|string',
            'short_term_date' => 'nullable|date',
            'long_term_action' => 'nullable|string',
            'long_term_date' => 'nullable|date',
            'completion_date' => 'nullable|date',
            'date_of_closure' => 'required|date',
            'follow_up_date' => 'required|date',
            'evidence_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', 
        ]);

        if($validator->fails()){
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $selectedCheckliskQuestion = SelectedChecklistQuestion::findOrFail($request->question_id);
        $selectedCheckliskQuestion->update([                    
            'question_response' => $request->question_response,
            'finding_observation' => $request->finding_observation,
            'action_taken' => $request->action_taken,
            'status' => $request->status,
            'finding_category' => $request->finding_category,
            'date_quality_control' => $request->date_quality_control,
            'problem_cause' =>$request->problem_cause,
            'proposed_follow_up_action' => $request->proposed_follow_up_action,
            'short_term_action' => $request->short_term_action,
            'long_term_action' => $request->long_term_action,
            'completion_date' => $request->completion_date,
            'date_of_closure' => $request->date_of_closure,
            'follow_up_date' => $request->follow_up_date,
            'immediate_corrective_action' => $request->immediate_corrective_action,
            'recommendations' => $request->recommendations,
            'reference' => $request->reference,
            'short_term_date' => $request->short_term_date,
            'long_term_date' => $request->long_term_date,

        ]);

        if ($request->hasFile('evidence_file')) {
            // Delete old file if exists
            if ($selectedCheckliskQuestion->evidence_file) {
                Storage::disk('public')->delete($selectedCheckliskQuestion->evidence_file);
            }
            $selectedCheckliskQuestion->evidence_file = $request->file('evidence_file')->store('qc_evidences', 'public');
        }
        
        $selectedCheckliskQuestion->save();
        return redirect()->route('quality-controls.show',$request->quality_control_id)->with('success', 'Checklist updated successfully.');        
    }
}
