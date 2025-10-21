<?php

namespace App\Http\Controllers;

use App\Models\SpecialisedTraining;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use App\Services\ActivityLogger;
use Illuminate\Support\Facades\Auth;

class SpecialisedTrainingController extends Controller implements HasMiddleware
{
    protected ActivityLogger $activityLogger;

    public function __construct(ActivityLogger $activityLogger)
    {
        $this->activityLogger = $activityLogger;
    }

    public static function middleware():array {
        return [
            new Middleware('permission:manage specialised trainings', only: ['index','create','store','edit','update','destroy']),
        ];
    }

    public function create($id)
    {
        $personnel = User::findOrFail($id); // Validate the user exists        
        return Inertia::render('SpecialisedTrainings/Create', [                 
            'personnel' => $personnel,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'training_name' => 'required|string|max:255',
            'training_center' => 'required|string|max:255',
            'certificate_number' => 'required|string|max:255',
            'date_issued' => 'required|date',
            'expiry_date' => 'required|date|after_or_equal:date_issued',
            'status' => 'required|string',
            'attachment' => 'nullable|mimes:pdf|max:2048'
        ]);

        if ($request->hasFile('attachment')) {
            $validated['attachment'] = $request->file('attachment')->store('specialised_trainings', 'public');
        }

        SpecialisedTraining::create($validated);
        $this->activityLogger->info('Created Specialised Training',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        //return redirect()->back()->with('success', 'Specialised training added successfully!');
        return redirect()
            ->route('officers.show', $request->user_id)
            ->with('success', 'Specialised training added successfully!.');
    }

    public function destroy($id)
    {
        try {
            $course = SpecialisedTraining::findOrFail($id);

            // Delete attached file if it exists
            if ($course->attachment && Storage::exists('public/' . $course->attachment)) {
                Storage::delete('public/' . $course->attachment);
            }

            // Delete record from the database
            $course->delete();
            $this->activityLogger->warning('Deleted Specialised Training',[
                'User Name' => Auth::user()->name,
                'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
                'IP'=> request()->ip(),
                'Time' => now(),
            ]);

            return response()->json([
                'message' => 'Specialised training deleted successfully.'
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'error' => 'Specialised trainig not found.'
            ], 404);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to delete the specialised training. Please try again.'
            ], 500);
        }
    }

    public function edit(string $id)
    {    
        $specialisedtraining = SpecialisedTraining::findOrFail($id);          
        return Inertia::render('SpecialisedTrainings/Edit', [
             'specialisedtraining' => $specialisedtraining,             
             'user_id' => $specialisedtraining->user_id,
        ]);
    }

    public function update(Request $request, $id)
    {
        $training = SpecialisedTraining::findOrFail($id);

        $validator = Validator::make($request->all(), [
            'training_name' => 'required|string|max:255',
            'training_center' => 'nullable|string|max:255',
            'certificate_number' => 'nullable|string|max:255',
            'date_issued' => 'nullable|date',
            'expiry_date' => 'nullable|date|after_or_equal:date_issued',
            'status' => 'nullable|string|max:255',
            'attachment' => 'nullable|file|mimes:pdf|max:2048', // PDF only, max 2MB
        ]);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        // Update fields
        $training->training_name = $request->training_name;
        $training->training_center = $request->training_center;
        $training->certificate_number = $request->certificate_number;
        $training->date_issued = $request->date_issued;
        $training->expiry_date = $request->expiry_date;
        $training->status = $request->status;

        // Handle file upload
        if ($request->hasFile('attachment')) {
            // Delete old file if exists
            if ($training->attachment && Storage::disk('public')->exists($training->attachment)) {
                Storage::disk('public')->delete($training->attachment);
            }

            // Store new file
            $path = $request->file('attachment')->store('specialised_trainings', 'public');
            $training->attachment = $path;
        }

        $training->save();

        $this->activityLogger->info('Updated Specialised Training',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
        return response()->json([
            'message' => 'Specialised Training updated successfully',
            'specialisedtraining' => $training
        ], 200);
    }

}
