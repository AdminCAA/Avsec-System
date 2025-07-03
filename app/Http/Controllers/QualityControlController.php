<?php

namespace App\Http\Controllers;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use App\Models\Facility;
use Inertia\Inertia;
use App\Models\QualityControl;
use App\Models\AuditQuestion;
use App\Models\SelectedChecklistQuestion;
use Illuminate\Http\Request;


class QualityControlController extends Controller
{
    //
    public function index(Request $request)
    {
        // Fetch all facilities from the database
        $searchQuery = QualityControl::with('facility')->search($request);
        $qualityControls =  $searchQuery->orderBy('created_at','desc')->paginate(100);
        // Return the facilities to the view
        return Inertia::render('QualityControls/List', [
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
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
        //Get all quality control types from the QualityControl model
        $qualityControlTypes = QualityControl::CONTROL_TYPE;
        //Get all the facilities from the Facility model
        $facilities = Facility::all();
        //Find the quality control record by id
        $qualityControl = QualityControl::with('facility')->findOrFail($id);   
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
            'selectedCheckListQuestions'=>'array'           
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
            return redirect()->route('quality-controls.index')->with('success', 'Quality Control updated successfully.');
        }
        return response()->json(['errors' => $validator->errors()], 422);
    }

    public function show($id)
    {    
        //Find the quality control record by id
        $qualityControl = QualityControl::with('facility')->findOrFail($id);        
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
            ]);                       
            return redirect()->route('quality-controls.index')->with('success', 'Quality Control created successfully.');
        }
        return response()->json(['errors' => $validator->errors()], 422);
    }


    public function saveQuestionResponse(Request $request,string $id){
        $validator = Validator::make($request->all(),[
            'question_id' => 'required|integer',
            'quality_control_id' => 'required|integer',
            'question_response' => 'required|string|in:Yes,No,N/A,N/C',
            'finding_observation' => 'nullable|string',
            'action_taken' => 'nullable|string',
            'status' => 'required|string|in:Open,Closed,Needs Follow up',
            'finding_category' => 'required|string|in:Compliant,Non Compliant(Minor),Not Compliant(Serious),Not Applicable,Not Confirmed',
            'date_quality_control' => 'required|date',
            'problem_cause' => 'required|string',
            'proposed_follow_up_action' => 'nullable|string',
            'short_term_action' => 'nullable|string',
            'long_term_action' => 'nullable|string',
            'completion_date' => 'nullable|date',
            'date_of_closure' => 'required|date',
            'follow_up_date' => 'required|date'
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
        ]);
        return redirect()->route('quality-controls.show',$request->quality_control_id)->with('success', 'Checklist updated successfully.');        
    }
}
