<?php

namespace App\Http\Controllers;

use App\Models\Facility;
use App\Models\MandatoryCourse;
use App\Models\Training;
use App\Models\User;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use setasign\Fpdi\Fpdi;          // FPDI
use setasign\Fpdi\PdfParser\StreamReader; // StreamReader helper (correct namespace)
use setasign\Fpdi\Fpdi\Fpdi as FPDI_TTF; // If you want explicit tFPDF usage


class MandatoryCourseController extends Controller
{

    public function create($id)
    {
        $personnel = User::findOrFail($id); // Validate the user exists        
        return Inertia::render('MandatoryCourses/Create', [                 
            'personnel' => $personnel,
        ]);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'course_name' => 'required|string|max:255',
            'training_center' => 'nullable|string|max:255',
            'certificate_number' => 'nullable|string|max:255',
            'date_issued' => 'nullable|date',
            'expiry_date' => 'nullable|date',
            'status' => 'nullable|string|max:255',
            'attachment' => 'nullable|file|mimes:pdf,jpg,jpeg,png',
        ]);

        if ($request->hasFile('attachment')) {
            $validated['attachment'] = $request->file('attachment')
                ->store('mandatory_courses', 'public');
        }

        MandatoryCourse::create($validated);

        // Redirect to OFFICERS.show instead of personnels.show
        return redirect()
            ->route('officers.show', $request->user_id)
            ->with('success', 'Mandatory course added successfully.');
    }

    public function destroy($id)
    {
        try {
            $course = MandatoryCourse::findOrFail($id);

            // Delete attached file if it exists
            if ($course->attachment && Storage::exists('public/' . $course->attachment)) {
                Storage::delete('public/' . $course->attachment);
            }

            // Delete record from the database
            $course->delete();

            return response()->json([
                'message' => 'Mandatory course deleted successfully.'
            ], 200);

        } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
            return response()->json([
                'error' => 'Mandatory course not found.'
            ], 404);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to delete the mandatory course. Please try again.'
            ], 500);
        }
    }

    public function edit(string $id)
    {    
        $mandatorycourses = MandatoryCourse::findOrFail($id);          
        return Inertia::render('MandatoryCourses/Edit', [
             'mandatorycourses' => $mandatorycourses,             
             'user_id' => $mandatorycourses->user_id,
        ]);
    }

    public function update(Request $request, $id)
    {
        $mandatoryCourse = MandatoryCourse::findOrFail($id);

        // Validation rules (match store)
        $validator = Validator::make($request->all(), [
            'course_name' => 'required|string|max:255',
            'training_center' => 'nullable|string|max:255',
            'certificate_number' => 'nullable|string|max:255',
            'date_issued' => 'nullable|date',
            'expiry_date' => 'nullable|date|after_or_equal:date_issued',
            'status' => 'nullable|string|max:255',
            'attachment' => 'nullable|file|mimes:pdf,jpg,jpeg,png|max:2048', // match store rules
        ]);

        if ($validator->fails()) {
            return response()->json([
                'errors' => $validator->errors()
            ], 422);
        }

        // Update fields
        $mandatoryCourse->course_name = $request->course_name;
        $mandatoryCourse->training_center = $request->training_center;
        $mandatoryCourse->certificate_number = $request->certificate_number;
        $mandatoryCourse->date_issued = $request->date_issued;
        $mandatoryCourse->expiry_date = $request->expiry_date;
        $mandatoryCourse->status = $request->status;

        // Handle file upload
        if ($request->hasFile('attachment')) {
            // Delete old file if exists
            if ($mandatoryCourse->attachment && Storage::disk('public')->exists($mandatoryCourse->attachment)) {
                Storage::disk('public')->delete($mandatoryCourse->attachment);
            }

            // Store new file on public disk
            $path = $request->file('attachment')->store('mandatory_courses', 'public');
            $mandatoryCourse->attachment = $path;
        }

        $mandatoryCourse->save();

        return response()->json([
            'message' => 'Mandatory Course updated successfully',
            'mandatoryCourse' => $mandatoryCourse
        ], 200);
    }

    public function downloadStaffPDF($id)
    {
        $user = User::with(['qualifications', 'mandatorycourse', 'specialisedtraining'])->findOrFail($id);

        $pdf = Pdf::loadView('pdfTemplates.staffDetails', [
            'personnel' => $user, // passing User as personnel
            'qualifications' => $user->qualifications ?? [],
            'mandatorycourse' => $user->mandatorycourse ?? [],
            'specialisedtraining' => $user->specialisedtraining ?? [],
            //'certifications' => $user->certifications ?? [],
        ])->setPaper('a4', 'portrait'); // landscape if you want

        return $pdf->download("staff_{$user->name}.pdf");
    }





}
