<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Department;
use Illuminate\Http\Request;
use App\Models\Facility;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;


class FacilityController extends Controller
{
       
    public function index(Request $request)
    {        
        
        // Ensure the user is authenticated
        if (!Auth::check()) {
            return redirect()->route('login');
        }
        // Get the current user
        $currentUser = Auth::user();
        // Get all facilities for the current user's department
        $searchQuery = Facility::search($request);
        // If the user is an admin, show all facilities
        
        /*
        if ($currentUser->isAdmin()) {
            $facilities = $searchQuery->orderBy('category','asc')->paginate(50);
            // Return the facilities to the view
            return Inertia::render('Facilities/List', [
                'facilities' => $facilities,
                'search' => $request->search ?? '',
            ]);
        }
        */

        $facilities =  $searchQuery->orderBy('category','asc')->paginate(50);
        //$facilities =  $searchQuery->where('department_id',$currentUser->department_id)->orderBy('category','asc')->paginate(50);
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
        //Get all Departments from the Department model
        $departments = Department::all();
        
        sort($categories);
        return Inertia::render('Facilities/Create', [
            'categories' => $categories,    
            'departments' => $departments,                   
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
            $department = Department::find($request->department_id);
            Facility::create([
                'name' => trim($request->name),
                'department_id' => $department ? $department->id : null, // Associate with department if provided                
                'description' => trim($request->description),
                'category' => trim($request->category),
                'location' => trim($request->location),
                'address' => trim($request->address),
                'contact_number' => trim($request->contact_number),
                'email' => trim($request->email),
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
        $facility = Facility::with(['qualityControls','users'])->findOrFail($id);    
        $usersCount = $facility->users()->count();
        $audits = $facility->qualityControls()->with('users')->where('control_type', 'Audit')->paginate(2, ['*'], 'audits_page');
        $inspections = $facility->qualityControls()->with('users')->where('control_type', 'Inspection')->paginate(2, ['*'], 'inspections_page');
        $securityTests = $facility->qualityControls()->with('users')->where('control_type', 'Security Test')->paginate(2, ['*'], 'security_tests_page');

        $qualityControlCounts = [
            'audits' => $facility->qualityControls->where('control_type', 'Audit')->count(),
            'inspections' => $facility->qualityControls->where('control_type', 'Inspection')->count(),
            'securityTests' => $facility->qualityControls->where('control_type', 'Security Test')->count(),
        ];

        $operatorStats = Facility::where('id', $id)
            ->withCount([
                'qualityControls as completed_count' => function ($q) {
                    $q->where('status', 'Completed');
                    //->whereHas('selectedChecklistQuestions');
                },
                'qualityControls as overdue_count' => function ($q) {
                    $q->where('status', 'Overdue');
                    //->whereHas('selectedChecklistQuestions');
                },
                'qualityControls as in_progress_count' => function ($q) {
                    $q->where('status', 'In Progress');
                    //->whereHas('selectedChecklistQuestions');
                },
                'qualityControls as pending_count' => function ($q) {
                    $q->where('status', 'Pending');
                    //->whereHas('selectedChecklistQuestions');
                }
            ])->first();



        // Return the facility to the show view
        return Inertia::render('Facilities/Show', [                     
            'qualityControlCounts' => $qualityControlCounts,
            'audits' => $audits,
            'inspections' => $inspections,
            'securityTests' => $securityTests,    
            'usersCount'  => $usersCount,
            'facility' => $operatorStats
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
        // Get all Departments from the Department model
        $departments = Department::all();
        sort($categories);
        // Return the facility to the edit view
        return Inertia::render('Facilities/Edit', [
            'facility' => $facility,
            'categories' => $categories,
            'departments' => $departments,
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
            $department = Department::find($request->department_id);
            $facility->update([
                'name' => trim($request->name),
                'department_id' => $department ? $department->id : null,                
                'description' => trim($request->description),
                'category' => trim($request->category),
                'location' => trim($request->location),
                'address' => trim($request->address),
                'contact_number' => trim($request->contact_number),
                'email' => trim($request->email),
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
