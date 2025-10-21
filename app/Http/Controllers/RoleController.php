<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Request;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use App\Services\ActivityLogger;
use Illuminate\Support\Facades\Auth;

class RoleController extends Controller implements HasMiddleware
{
    protected ActivityLogger $activityLogger;

    public function __construct(ActivityLogger $activityLogger)
    {
        $this->activityLogger = $activityLogger;
    }
    
    public static function middleware():array {
        return [
            new Middleware('permission:manage roles', only: ['index','create','store','edit','update','destroy']),
        ];
    }
    
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //Fetch all roles with permissions
        $roles = Role::with('permissions')->orderBy('name','ASC')-> paginate(30);        
        return inertia('Roles/List', [
            'roles' => $roles,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //Fetch all permissions
        $permissions = Permission::orderBy('created_at','DESC')->get();
        return inertia('Roles/Create', [
            'permissions' => $permissions,
        ]);

    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {    
        //Validate the request
        $validator =  Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:roles,name',
            'permissions' => 'array',
        ]);

        if($validator->passes()){
            $role = Role::create(['name' => $request->name]);
            $this->activityLogger->info('Created Role',[
                'User Name' => Auth::user()->name,
                'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
                'IP'=> request()->ip(),
                'Time' => now(),
            ]);
            if(!empty($request->permissions)){
                $role->syncPermissions($request->permissions);
            }
            return redirect()->route('roles.index')->with('success', 'Role created successfully.');
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
        $role = Role::findOrFail($id);
        $hasPermissions = $role->permissions->pluck('name');        
        $permissions = Permission::orderBy('name','asc')->get();

        return inertia('Roles/Edit', [
            'role' => $role,
            'permissions' => $permissions,
            'hasPermissions' => $hasPermissions,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {        
        $role = Role::findOrFail($id);        
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:roles,name,'.$id.',id',
            'permissions' => 'array',
        ]);

        if($validator->passes()){
            $role->name = $request->name;
            $role->save();

            $this->activityLogger->info('Updated Role',[
                'User Name' => Auth::user()->name,
                'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
                'IP'=> request()->ip(),
                'Time' => now(),
            ]);

            if(!empty($request->permissions)){
                $role->syncPermissions($request->permissions);
            }else{
                $role->syncPermissions([]);
            }
            return redirect()->route('roles.index')->with('success', 'Role updated successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }

        
    }
    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {
        $role = Role::find($id);
        if(!$role || $role->id != $id) {
            return response()->json(['error' => 'Role not found,try again.'], 404);
        }

        //Check if the role is assigned to any user
        if($role->users()->count() > 0) {
            return response()->json(['error' => 'Role cannot be deleted because it has user assigned to  it.'], 422);
        }
        //Delete the role
        $role->delete();

        $this->activityLogger->warning('Deleted Role',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return response()->json([
            'success' => 'Role deleted successfully.'
            ], 200);

    }
}
