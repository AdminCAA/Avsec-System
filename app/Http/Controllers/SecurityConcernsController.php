<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\SelectedChecklistQuestion;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;

class SecurityConcernsController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Fetch all security concerns from the database
        $searchQuery = SelectedChecklistQuestion::with('qualityControl')->search($request);
        $questionsWithConcerns = $searchQuery->orderBy('updated_at','DESC')->whereIn('status',['Open','Overdue'])->paginate(50);

        return Inertia::render('SecurityConcerns/List', [
            'questionsWithConcerns' => $questionsWithConcerns,   
            'search' => $request->search ?? '',    
        ]);
        
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
        $question = SelectedChecklistQuestion::findOrFail($id);        
        $qualityControl = $question->qualityControl;
        $followups = $question->followups()->orderBy('created_at', 'DESC')->get();
        $facility = $qualityControl->facility ?? null;
        
        return Inertia::render('SecurityConcerns/Edit', [
            'question' => $question,
            'qualityControl' => $qualityControl,
            'facility' => $facility,
            'followups' => $followups,            
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
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
            'problem_cause' => 'required|string',
            'proposed_follow_up_action' => 'nullable|string|in:Onsite,Administrative,Onsite and Administrative',
            'short_term_action' => 'nullable|string',
            'short_term_date' => 'nullable|date',
            'long_term_action' => 'nullable|string',
            'long_term_action' => 'nullable|string',
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


    public function securityConcernsCount()
    {
        // Count the number of security concerns
        $count = SelectedChecklistQuestion::whereIn('status', ['Open', 'Overdue'])->count();
        return response()->json(['count' => $count]);
    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }

    public function generateCar(string $id)
    {
        // Find the selected checklist question by ID        
        
        $question = SelectedChecklistQuestion::findOrFail($id);        
        $qualityControl = $question->qualityControl;                
        $facility = $qualityControl->facility ?? null;
        $users = $qualityControl->users()->get();
        // Check if the question has an immediate corrective action
        if (!$question->immediate_corrective_action) {
            return redirect()->back()->with('error', 'Immediate corrective action is required to generate a CAR.');
        }
        // Generate the CAR PDF
        $pdf = PDF::loadView('pdfTemplates.car', [
            'question' => $question,
            'qualityControl' => $qualityControl,
            'operator' => $facility,
            'users'=>$users
        ]);
        // Return the generated PDF as a download
        return $pdf->download('car_' . $question->id . '.pdf');

    }
}
