<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Spatie\Permission\Models\Permission;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class PermissionController extends Controller implements HasMiddleware
{
    public static function middleware():array {
        return [
            new Middleware('permission:manage permissions', only: ['create','store','edit','update','destroy']),
        ];
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $permissions = Permission::orderBy('created_at','DESC')-> paginate(30);
        return inertia('Permissions/List', [
            'permissions' => $permissions,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        return inertia('Permissions/Create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:permissions,name',
            'permissions' => 'array',
        ]);
    
        if ($validator->fails()) {
             return response()->json(['errors' => $validator->errors()], 422);
        }
    
        Permission::create(['name' => $request->name]);    
        return redirect()->route('permissions.index')->with('success', 'Permission created successfully.');
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
        $permission  = Permission::findOrFail($id);        
        return inertia('Permissions/Edit', ['permission' => $permission]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        //
        $permission = Permission::findOrFail($id);
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255|unique:permissions,name,'.$id.',id',
        ]);
        if($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $permission->name = $request->name;
        $permission->save();
        return redirect()->route('permissions.index')->with('success', 'Permission updated successfully.');

    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {                
        $permission = Permission::find($id);          
        if (!$permission || $permission->id != $id) {
            return response()->json(
                ['error' => 'Permission not found.'], 
                404
            );
        }
        $permission->delete();
        return response()->json(
            ['success' => 'Permission deleted successfully.',
            'status' => true
            ], 
            200
        );
    }
}
