<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Facility;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;


class FacilityController extends Controller
{
       
    public function index(Request $request)
    {        
        // Fetch all facilities from the database
        $searchQuery = Facility::search($request);
        $facilities =  $searchQuery->orderBy('category','asc')->paginate(50);
        // Return the facilities to the view
        return Inertia::render('Facilities/List', [
            'facilities' => $facilities,
            'search' => $request->search ?? '',
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //Get all categories from the Facility model
        $categories = Facility::CATEGORIES;
        sort($categories);
        return Inertia::render('Facilities/Create', [
            'categories' => $categories,           
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {    
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'string|max:1000',
            'category' => 'required|string|in:' . implode(',', Facility::CATEGORIES),
            'location' => 'string|max:255',
            'address' => 'string|max:255',
            'contact_number' => 'required|string|max:20',
            'email' => 'email|max:255',
        ]);

        // Check if validation passes
        if($validator->passes()){
            // Create a new facility
            Facility::create([
                'name' => $request->name,
                'description' => $request->description,
                'category' => $request->category,
                'location' => $request->location,
                'address' => $request->address,
                'contact_number' => $request->contact_number,
                'email' => $request->email,
            ]);
            // Redirect to the facilities list with a success message
            return redirect()->route('facilities.index')->with('success', 'Operator created successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        $facility = Facility::with('qualityControls')->findOrFail($id);    
        
        $audits = $facility->qualityControls()->where('control_type', 'Audit')->paginate(2, ['*'], 'audits_page');
        $inspections = $facility->qualityControls()->where('control_type', 'Inspection')->paginate(2, ['*'], 'inspections_page');
        $securityTests = $facility->qualityControls()->where('control_type', 'Security Test')->paginate(2, ['*'], 'security_tests_page');

        $qualityControlCounts = [
            'audits' => $facility->qualityControls->where('control_type', 'Audit')->count(),
            'inspections' => $facility->qualityControls->where('control_type', 'Inspection')->count(),
            'securityTests' => $facility->qualityControls->where('control_type', 'Security Test')->count(),
        ];
        // Return the facility to the show view
        return Inertia::render('Facilities/Show', [
            'facility' => $facility,            
            'qualityControlCounts' => $qualityControlCounts,
            'audits' => $audits,
            'inspections' => $inspections,
            'securityTests' => $securityTests,            
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
        // Find the facility by ID
        $facility = Facility::findOrFail($id);
        // Get all categories from the Facility model
        $categories = Facility::CATEGORIES;
        sort($categories);
        // Return the facility to the edit view
        return Inertia::render('Facilities/Edit', [
            'facility' => $facility,
            'categories' => $categories,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        // Find the facility by ID
        $facility = Facility::findOrFail($id);
        // Validate the request data
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'nullable|string|max:1000',
            'category' => 'required|string|in:' . implode(',', Facility::CATEGORIES),
            'location' => 'nullable|string|max:255',
            'address' => 'nullable|string|max:255',
            'contact_number' => 'nullable|string|max:20',
            'email' => 'nullable|email|max:255',
        ]);
        // Check if validation passes
        if($validator->passes()){
            // Update the facility
            $facility->update([
                'name' => $request->name,
                'description' => $request->description,
                'category' => $request->category,
                'location' => $request->location,
                'address' => $request->address,
                'contact_number' => $request->contact_number,
                'email' => $request->email,
            ]);
            
            // Redirect to the facilities list with a success message
            return redirect()->route('facilities.index')->with('success', 'Operator updated successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $facility = Facility::find($id);
        if (!$facility || $facility->id != $id) {
            return response()->json(['error' => 'Operator not found'], 404);
        }
        // Delete the facility
        $facility->delete();
        // Redirect to the facilities list with a success message
        return response()->json(
            ['success' => 'Operator deleted successfully.',
            'status' => true
            ], 
            200
        );
    }

    public function downloadOperatorsPDF(){
        
        $operators = Facility::all();        
        $pdf = Pdf::loadView('pdfTemplates.operators', [
            'operators' => $operators,
        ]);
        return $pdf->download('operators.pdf');        
    }




}
