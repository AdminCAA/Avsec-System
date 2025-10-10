<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\FollowUp;
use Illuminate\Http\Request;
use Inertia\Inertia;
use App\Models\SelectedChecklistQuestion;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class FollowupController extends Controller implements HasMiddleware
{
    public static function middleware():array {
        return [
            new Middleware('permission:manage quality control followups', only: ['index','create','store','edit','update','destroy']),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create(string $id)
    {                      
        return Inertia::render('Followups/Create'
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
       $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'followup_comments' => 'string|max:1000',
            'followup_date' => 'required|date',
        ]);
        // Check if validation passes
        if ($validator->fails()) {            
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $id = $request->selected_checklist_question_id;
        $selectedChecklistQuestion = SelectedChecklistQuestion::findOrFail($id);
        $selectedChecklistQuestion->followups()->create([
            'user_id' => Auth::id(),
            'title' => trim($request->title),
            'user_name' => Auth::user()->name,
            'followup_comments' => trim($request->followup_comments),
            'followup_date' => $request->followup_date,
        ]);
        return redirect()->route('securityconcerns.edit', $id)->with('success', 'Followup created successfully.');
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
        $followup  = FollowUp::findOrFail($id);
        return Inertia::render('Followups/Edit',
            [
                'followup' => $followup
            ]
        );
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validator = Validator::make($request->all(), [
            'title' => 'required|string|max:255',
            'followup_comments' => 'string|max:2000',
            'followup_date' => 'required|date',
        ]);
        // Check if validation passes
        if ($validator->fails()) {            
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $followup = FollowUp::findOrFail($id);
        $followup->update([            
            'title' => $request->title,            
            'followup_comments' => $request->followup_comments,
            'followup_date' => $request->followup_date,
        ]);
        return redirect()->route('securityconcerns.edit', $followup->selected_checklist_question_id)->with('success', 'Followup created successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        // Find the quality control record by id
        $followup = FollowUp::find($id);        
        if (!$followup || $followup->id != $id) {
            return response()->json(['error' => 'Followup not found'], 404);
        }
        // Delete the quality control record
        $followup->delete();
        // Redirect to the quality controls list with a success message
        return response()->json(
            ['success' => 'Followup deleted successfully.',
            'status' => true
            ], 
            200
        );    
    }
}
