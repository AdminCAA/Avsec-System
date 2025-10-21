<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Certification;
use App\Models\Training;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Storage;
use Inertia\Inertia;
use App\Services\ActivityLogger;
use Illuminate\Support\Facades\Auth;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class CertificationsController extends Controller implements HasMiddleware
{
    protected ActivityLogger $activityLogger;

    public function __construct(ActivityLogger $activityLogger)
    {
        $this->activityLogger = $activityLogger;
    }
    
    public static function middleware():array {
        return [
            new Middleware('permission:manage certifications', only: ['index','create','store','edit','update','destroy']),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        // Fetch all certifications from the database

    }

    /**
     * Show the form for creating a new resource.
     */
    public function create($id)
    {
        $personnel = User::findOrFail($id); // Validate the user exists
        $trainings = Training::all();
        return Inertia::render('Certifications/Create', [                 
            'user_id' => $personnel->id,
            'trainings' => $trainings,
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
            'certification_type' => 'required|string|max:255',
            'certification_name' => 'required|string|max:255',
            'certification_body' => 'required|string|max:255',
            'date_issued' => 'required|date|before:expiry_date',
            'expiry_date' => 'required|date|after:date_issued',
            'certification_number' => 'nullable|string|max:255',
            'status' => 'required|string|in:Active,Expired,Suspended', 
            'score' => 'nullable|integer|min:0|max:100', 
            'remarks' => 'nullable|string|max:500',
            'certification_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', 
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $certification = new Certification();
        $certification->user_id = $request->user_id;
        $certification->certification_type = trim($request->certification_type);
        $certification->certification_name = trim($request->certification_name);
        $certification->certification_body = trim($request->certification_body);
        $certification->date_issued = $request->date_issued;
        $certification->expiry_date = $request->expiry_date;
        $certification->certification_number = trim($request->certification_number);
        $certification->status = trim($request->status);
        $certification->score = $request->score;
        $certification->remarks = trim($request->remarks);
        if ($request->hasFile('certification_file')) {
            $certification->certification_file = $request->file('certification_file')->store('certifications', 'public');
        }
        $certification->save();

        $this->activityLogger->info('Created User Certification',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('personnels.show', $request->user_id)->with('success', 'Certification created successfully.');        
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
         $certification = Certification::findOrFail($id); 
         $trainings = Training::all();
         return Inertia::render('Certifications/Edit', [
             'certification' => $certification,
             'trainings' => $trainings,
             'user_id' => $certification->user_id,
         ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $certification = Certification::findOrFail($id);
        $validator = Validator($request->all(),[
            'certification_type' => 'required|string|max:255',
            'certification_name' => 'required|string|max:255',
            'certification_body' => 'required|string|max:255',
            'date_issued' => 'required|date|before:expiry_date',
            'expiry_date' => 'required|date|after:date_issued',
            'certification_number' => 'nullable|string|max:255',
            'status' => 'required|string|in:Active,Expired,Suspended', 
            'score' => 'nullable|integer|min:0|max:100', 
            'remarks' => 'nullable|string|max:500',
            'certification_file' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', 
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $certification->certification_type = trim($request->certification_type);
        $certification->certification_name = trim($request->certification_name);
        $certification->certification_body = trim($request->certification_body);
        $certification->date_issued = $request->date_issued;
        $certification->expiry_date = $request->expiry_date;
        $certification->certification_number = trim($request->certification_number);
        $certification->status = trim($request->status);
        $certification->score = $request->score;
        $certification->remarks = trim($request->remarks);
        
        if ($request->hasFile('certification_file')) {
            // Delete the old file if it exists
            if ($certification->certification_file) {
                Storage::disk('public')->delete($certification->certification_file);
            }
            $certification->certification_file = $request->file('certification_file')->store('certifications', 'public');
        }
        $certification->save();

        $this->activityLogger->info('Updated User Certification',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('personnels.show', $certification->user_id)->with('success', 'Certification updated successfully.');

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //    
        $certification = Certification::find($id);
        if (!$certification || $certification->id != $id) {
            return response()->json(['error' => 'Certification was not found'], 404);
        }

        if ($certification->certification_file && Storage::disk('public')->exists($certification->certification_file)) {
            // Delete the certification file if it exists
            Storage::disk('public')->delete($certification->certification_file);
        }
        // Delete the facility
        $certification->delete();  

        $this->activityLogger->warning('Deleted User Certification',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
      
        // Redirect to the personnel list with a success message
        return response()->json(
            ['success' => 'Certification deleted successfully.',
            'status' => true
            ], 
            200
        );
    }
}
