<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Facility;
use App\Models\Training;
use App\Models\User;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\DB;

class PersonnelController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {        
        $searchQuery = User::search($request);
        // Fetch all personnel from the database
        $personnels = $searchQuery->whereIn('user_type', User::UserTypes)->orderBy('created_at', 'desc')
        ->paginate(50);
        return Inertia::render('Personnels/List',[
            'personnels' => $personnels                
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $facilities = Facility::orderBy('name','ASC')->get();        
        $trainings = Training::orderBy('created_at', 'desc')->get();        
        $userTypes = User::UserTypes;
        $userStatuses = User::UserStatuses;
        
        return Inertia::render('Personnels/Create', [
            'trainings' => $trainings,
            'facilities' => $facilities,
            'userTypes' => $userTypes,
            'userStatuses' => $userStatuses,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
         // For debugging purposes, remove in production
        $validator = Validator::make($request->all(),[
            'portrait' => 'nullable|image|max:2048', // Optional portrait validation
            'name' => 'required|string|max:255',
            'email' => 'required|email|max:255|unique:users,email',
            'nrc'=>'required|string|max:20',
            'gender'=> 'required|string|max:6',
            'phone_number' => 'nullable|string|max:20',
            'password' => ['required','string', Password::min(8)
                    ->mixedCase()
                    ->letters()
                    ->numbers()
                    ->symbols()                
                ],
            'facility_id' => 'required|exists:facilities,id',
            'user_type' => ['required', 'string', Rule::in(User::UserTypes)],
            'is_certified' => ['required', 'string', Rule::in(User::UserStatuses)],           
        ]);

        // Check if validation passes
        if ($validator->passes()) {
            // Create a new user
            // Ensure the facility exists
            $facility = Facility::findOrFail($request->facility_id);
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'nrc' => $request->nrc,
                'gender'=>$request->gender,
                'phone_number' => $request->phone_number,
                'password' => bcrypt($request->password),
                'facility_id' => $request->facility_id,
                'facility_name' => $facility->name,
                'user_type' => $request->user_type,
                'is_certified' => $request->is_certified,
            ]);

            // Handle portrait upload if provided
            if ($request->hasFile('portrait')) {
                $portraitPath = $request->file('portrait')->store('portraits', 'public');
                $user->portrait = $portraitPath;
                $user->save();
            }

            // Attach trainings if any
            // if ($request->has('selectedTrainings')) {
            //     $user->trainings()->sync($request->selectedTrainings);
            // }

            return redirect()->route('personnels.index')->with('success', 'Personnel created successfully.');
        } else {
            return response()->json(['errors' => $validator->errors()], 422);
        }        
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $personnel = User::findOrFail($id);
        $qualifications = $personnel->qualifications()->orderBy('created_at', 'desc')->get();
        $certifications = $personnel->certifications()->orderBy('created_at', 'desc')->get();

        return Inertia::render('Personnels/Show', [
            'personnel' => $personnel,
            'qualifications' => $qualifications,
            'certifications' => $certifications
        ]);        
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
        $personnel = User::findOrFail($id);
        $facilities = Facility::orderBy('name','ASC')->get();        
        $trainings = Training::orderBy('created_at', 'desc')->get();        
        $userTypes = User::UserTypes;
        $userStatuses = User::UserStatuses;
        
        return Inertia::render('Personnels/Edit', [
            //'trainings' => $trainings,
            'facilities' => $facilities,
            'userTypes' => $userTypes,
            'userStatuses' => $userStatuses,
            'personnel' => $personnel
        ]);
    }

  

public function update(Request $request, string $id)
{
    $user = User::findOrFail($id);

    // Validate request
    $validator = Validator::make($request->all(), [
        'portrait' => 'nullable|image|max:2048',
        'name' => 'required|string|max:255',
        'email' => [
            'required',
            'email',
            'max:255',
            Rule::unique('users')->ignore($user->id), // Ignore current user
        ],
        'nrc' => 'required|string|max:20',
        'gender' => 'required|string|max:6',
        'phone_number' => 'nullable|string|max:20',
        'password' => [
            'nullable', // Password should be optional on update
            'string',
            Password::min(8)->mixedCase()->letters()->numbers()->symbols()
        ],
        'facility_id' => 'required|exists:facilities,id',
        'user_type' => ['required', 'string', Rule::in(User::UserTypes)],
        'is_certified' => ['required', 'string', Rule::in(User::UserStatuses)],
    ]);

    if ($validator->fails()) {
        return response()->json(['errors' => $validator->errors()], 422);
    }

    DB::beginTransaction();

    try {
        $facility = Facility::findOrFail($request->facility_id);
        $user->update([
            'name' => $request->name,
            'email' => $request->email,
            'nrc' => $request->nrc,
            'gender' => $request->gender,
            'phone_number' => $request->phone_number,
            'password' => $request->password ? bcrypt($request->password) : $user->password,
            'facility_id' => $request->facility_id,
            'facility_name' => $facility->name,
            'user_type' => $request->user_type,
            'is_certified' => $request->is_certified,
        ]);

        // Handle portrait upload if provided
        if ($request->hasFile('portrait')) {
            if ($user->portrait && Storage::disk('public')->exists($user->portrait)) {
                Storage::disk('public')->delete($user->portrait);
            }

            $portraitPath = $request->file('portrait')->store('portraits', 'public');
            $user->update(['portrait' => $portraitPath]);
        }

        DB::commit();
        return redirect()->route('personnels.index')->with('success', 'Personnel updated successfully.');
    } catch (\Exception $e) {
        DB::rollBack();
        return response()->json(['error' => 'An error occurred while updating the user.'], 500);
    }
}


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $user = User::find($id);
        if ($user == null) {
            return response()->json(['errors' => 'User not found'], 404);
        }       
        // Delete the portrait if it exists
        if ($user->portrait && Storage::disk('public')->exists($user->portrait)) {
            Storage::disk('public')->delete($user->portrait);
        }
        $user->delete();
        return response()->json(
            [
                'success' => 'Personnel account deleted successfully.',
                'status' => true
            ], 200);    
    }
  
}
