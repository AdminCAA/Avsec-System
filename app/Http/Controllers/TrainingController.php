<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use App\Models\Training;

class TrainingController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {        
         // Fetch all facilities from the database
         $searchQuery = Training::search($request);
         $trainings =  $searchQuery->orderBy('created_at','desc')->paginate(50);
         // Return the facilities to the view                 
        return Inertia::render('Trainings/List', [
            'trainings' => $trainings,
            'search' => $request->search ?? '', 
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {        
        return Inertia::render('Trainings/Create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {        
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
        ]);
        // Check if validation passes
        if ($validator->passes()) {
            // Create a new training record
            Training::create([
                'title' => $request->name,
                'description' => $request->description,
            ]);
            return redirect()->route('trainings.index')->with('success', 'Training created successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }
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
        // Find the training by ID
        $training = Training::findOrFail($id);
        // Return the edit view with the training data
        return Inertia::render('Trainings/Edit', [
            'training' => $training,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
        ]);

        // Check if validation passes
        if ($validator->passes()) {
            // Find the training by ID
            $training = Training::findOrFail($id);
            // Update the training record
            $training->update([
                'title' => $request->name,
                'description' => $request->description,
            ]);
            return redirect()->route('trainings.index')->with('success', 'Training updated successfully.');
        } else {
            return response()->json(['errors' => $validator->errors()], 422);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $training = Training::findOrFail($id);
        // Delete the training record
        $training->delete();

        return response()->json(
            ['success' => 'Training record deleted successfully.',
            'status' => true
            ], 
            200
        );        
    }
}
