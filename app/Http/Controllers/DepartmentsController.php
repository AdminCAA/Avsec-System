<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Inertia\Inertia;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\Department; 
use App\Services\ActivityLogger;
use Illuminate\Support\Facades\Auth;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class DepartmentsController extends Controller implements HasMiddleware
{
    protected ActivityLogger $activityLogger;

    public function __construct(ActivityLogger $activityLogger)
    {
        $this->activityLogger = $activityLogger;
    }

    public static function middleware():array {
        return [
            new Middleware('permission:manage departments', only: ['index','create','store','edit','update','destroy']),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $departments = Department::orderBy('created_at', 'DESC')->paginate(20);
        return Inertia::render('Departments/List', [
            'departments' => $departments,           
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return Inertia::render('Departments/Create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'description' => 'string|max:1000',
        ]);
        // Check if validation passes
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        // Create a new department
        $department = new Department();
        $department->name = trim($request->name);
        $department->description = trim($request->description);
        $department->save();

        $this->activityLogger->info('Created Department',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
        return redirect()->route('departments.index')->with('success', 'Department created successfully.');
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
        $department = Department::findOrFail($id);
        return Inertia::render('Departments/Edit', [
            'department' => $department,
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
            'description' => 'string|max:1000',
        ]);
        // Check if validation passes
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        // Update the department
        $department = Department::findOrFail($id);
        $department->name = trim($request->name);
        $department->description = trim($request->description);
        $department->save();

        $this->activityLogger->info('Updated Department',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('departments.index')->with('success', 'Department updated successfully.');

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $department = Department::findOrFail($id);
        // Check if the department has any associated users
        // if ($department->users()->count() > 0) {
        //     return redirect()->route('departments.index')->with('error', 'Cannot delete department with associated users.');
        // }

        // Delete the department
        $department->delete();

        $this->activityLogger->warning('Deleted Department',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
        return response()->json(
            ['success' => 'Department deleted successfully.',
            'status' => true
            ], 
            200
        );
    }
}
