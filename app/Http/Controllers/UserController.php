<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Department;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Notification;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;

class UserController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
        $searchQuery = User::search($request);        
        $users =  $searchQuery->orderBy('created_at', 'desc')->paginate(50);
        $roles = Role::orderBy('name', 'asc')->get();
        return inertia('Users/List', [
            'users' => $users,
            'roles' => $roles,
            'search' => $request->search ?? '',
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        $roles = Role::orderBy('name', 'asc')->get();
        $departments = Department::all();
        return inertia('Users/Create', [
            'roles' => $roles,
            'departments' => $departments
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator::make($request->all(),
        [
            'portrait' => 'nullable|image|max:2048', // Optional portrait validation
            'name' => 'required|string|max:255|min:3',
            'email' => 'required|string|email|max:255|unique:users',
            'nrc'=>'required|string|max:20',
            'gender'=> 'required|string|max:6',
            'designation' => 'nullable|string|max:100',	
            'phone_number' => 'nullable|string|max:20',
            'password' => ['required','string','confirmed', Password::min(8)
                ->mixedCase()
                ->letters()
                ->numbers()
                ->symbols()                
            ],
            'roles' => 'array',
        ]);        
         // For debugging purposes, remove in production

        if($validator->passes()){
            $department = Department::find($request->department_id);
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'nrc' => $request->nrc,
                'gender'=>$request->gender,
                'designation' => $request->designation,
                'phone_number' => $request->phone_number,
                'department_id' => $department ? $department->id : null, 
                'department_name' => $department ? $department->name : null,
                'password' => bcrypt($request->password),
            ]);

            // Handle portrait upload if provided
            if ($request->hasFile('portrait')) {
                $portraitPath = $request->file('portrait')->store('portraits', 'public');
                $user->portrait = $portraitPath;
                $user->save();
            }
            // Assign roles to the user
            if(!empty($request->roles)){
                // Check if the role exists
                $user->syncRoles($request->roles);
            }else{
                // If no role is selected, assign the default role
                $user->syncRoles([]);
            }
            return redirect()->route('users.index')->with('success', 'User created successfully');
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
        //
        $user = User::find($id);
        $departments = Department::all();
        $userRoles = $user->roles->pluck('name');
        
        if($user == null){
            return response()->json(['errors' => 'User not found'], 404);
        }
        $roles = Role::orderBy('name', 'asc')->get();
        return inertia('Users/Edit', [
            'user' => $user,
            'roles' => $roles,
            'userRoles' => $userRoles,
            'departments'=>$departments
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $user = User::findOrFail($id);        
        $validator = Validator::make($request->all(),
        [
            'portrait' => 'nullable|image|max:2048', // Optional portrait validation
            'name' => 'required|string|max:255|min:3',
            'email' => 'required|string|email|max:255|unique:users,email,'.$id,
            'nrc'=>'required|string|max:20',
            'gender'=> 'required|string|max:6',
            'designation' => 'nullable|string|max:100',	
            'phone_number' => 'nullable|string|max:20',
            'password' => ['nullable','string','confirmed', Password::min(8)
                ->mixedCase()
                ->letters()
                ->numbers()
                ->symbols()                
            ],
            'roles' => 'array',
        ]);

        if($validator->passes()){        
            $department = Department::find($request->department_id);                       
            $user->name = $request->name;
            $user->email = $request->email;
            $user->nrc = $request->nrc;
            $user->gender = $request->gender;
            $user->designation = $request->designation;
            $user->phone_number = $request->phone_number;            
            // Handle portrait upload if provided
            if ($request->hasFile('portrait')) {
                if ($user->portrait && Storage::disk('public')->exists($user->portrait)) {
                    Storage::disk('public')->delete($user->portrait);
                }

                $portraitPath = $request->file('portrait')->store('portraits', 'public');
                $user->update(['portrait' => $portraitPath]);
            }

            // Update department if provided
            $user->department_id = $department ? $department->id : null; 
            $user->department_name = $department ? $department->name : null;

            if($request->password != null){
                $user->password = bcrypt($request->password);
            }
            $user->save();
            // Assign roles to the user
            if(!empty($request->roles)){
                // Check if the role exists
                $user->syncRoles($request->roles);
            }else{
                // If no role is selected, assign the default role
                $user->syncRoles([]);
            }            
            return redirect()->route('users.index')->with('success', 'User updated successfully');
        }
        else{
            return response()->json(['errors' => $validator->errors()], 422);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $user = User::find($id);
        if($user == null){
            return response()->json(['errors' => 'User not found'], 404);
        }
        if($user->id == Auth::id()){
            return response()->json(['errors' => 'You cannot delete your own account'], 403);
        }
        $user->delete();
        return response()->json([
            'success' => 'User deleted successfully',
            'status' => true
        ], 200);
    }

    public function disable2fa(Request $request, string $id)
    {
        $user = User::findOrFail($request->id);
        $user->two_factor_recovery_codes = null;
        $user->two_factor_secret = null;
        $user->save();      
        return redirect()->route('users.index')->with('success', 'Two Factor Authentication disabled successfully');       
    }
}
