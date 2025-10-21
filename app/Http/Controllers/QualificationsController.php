<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Qualification;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use App\Services\ActivityLogger;
use Illuminate\Support\Facades\Auth;



class QualificationsController extends Controller implements HasMiddleware
{
    protected ActivityLogger $activityLogger;

    public function __construct(ActivityLogger $activityLogger)
    {
        $this->activityLogger = $activityLogger;
    }

    public static function middleware():array {
        return [
            new Middleware('permission:manage qualifications', only: ['index','create','store','edit','update','destroy']),
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
    public function create($id)
    {
        $personnel = User::findOrFail($id); // Validate the user exists        
        return Inertia::render('Qualifications/Create', [                 
            'user_id' => $personnel->id,
            //'trainings' => $trainings,
        ]
        );
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator($request->all(),[
            'user_id' => 'required|exists:users,id',
            'qualification_type' => 'required|string|max:255',
            'qualification_name' => 'required|string|max:255',
            'institution' => 'required|string|max:255',
            'date_obtained' => 'required|date',            
            'qualification_number' => 'nullable|string|max:255',
            'qualification_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', 
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $qualification = new Qualification();
        $qualification->user_id = $request->user_id;
        $qualification->qualification_type = $request->qualification_type;
        $qualification->qualification_name = $request->qualification_name;        
        $qualification->institution = $request->institution;     
        $qualification->date_obtained = $request->date_obtained;        
        $qualification->qualification_number = $request->qualification_number;
        if ($request->hasFile('qualification_file')) {
            $qualification->qualification_file = $request->file('qualification_file')->store('qualifications', 'public');
        }
        $qualification->save();
        
        $this->activityLogger->info('Created Qualifications',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('personnels.show', $request->user_id)->with('success', 'Qualification created successfully.');        
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
        $qualification = Qualification::findOrFail($id);          
        return Inertia::render('Qualifications/Edit', [
             'qualification' => $qualification,             
             'user_id' => $qualification->user_id,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {        
        $qualification = Qualification::findOrFail($id);
        $validator = Validator($request->all(),[
            'qualification_type' => 'required|string|max:255',
            'qualification_name' => 'required|string|max:255',
            'institution' => 'required|string|max:255',
            'date_obtained' => 'required|date',            
            'qualification_number' => 'nullable|string|max:255',
            'qualification_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', 
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $qualification->qualification_type = $request->qualification_type;
        $qualification->qualification_name = $request->qualification_name;
        $qualification->institution = $request->institution;
        $qualification->date_obtained = $request->date_obtained;
        $qualification->qualification_number = $request->qualification_number;
        if ($request->hasFile('qualification_file')) {
            // Delete old file if exists
            if ($qualification->qualification_file) {
                Storage::disk('public')->delete($qualification->qualification_file);
            }
            $qualification->qualification_file = $request->file('qualification_file')->store('qualifications', 'public');
        }
        $qualification->save();

        $this->activityLogger->info('Updated Qualifications',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('personnels.show', $qualification->user_id)->with('success', 'Qualification updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        $qualification = Qualification::find($id);
        if (!$qualification || $qualification->id != $id) {
            return response()->json(['error' => 'Qualification was not found'], 404);
        }

        if ($qualification->qualification_file && Storage::disk('public')->exists($qualification->qualification_file)) {
            Storage::disk('public')->delete($qualification->qualification_file);
        }
        // Delete the facility
        $qualification->delete();   
        
        $this->activityLogger->warning('Deleted Qualifications',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
        // Redirect to the personnel list with a success message
        return response()->json(
            ['success' => 'Qualification deleted successfully.',
            'status' => true
            ], 
            200
        );
    }
}
