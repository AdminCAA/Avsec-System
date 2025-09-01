<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\AuditAreaCategory;
use Illuminate\Support\Facades\Validator;

class AuditAreaCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        // Fetch all audit area categories from the database
        $searchQuery = AuditAreaCategory::search($request);
        $auditAreaCategories = $searchQuery->orderBy('name', 'asc')->paginate(50);
        return inertia('AuditCategories/List', [
            'auditAreaCategories' => $auditAreaCategories,
            'search' => $request->search ?? '',
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
        //Fetch all audit area categories
        $categories = AuditAreaCategory::CATEGORIES;
        return inertia('AuditCategories/Create', [
            'categories' => $categories,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',   
            'category_name' => 'required|string|max:255',       
        ]);
        // Check if validation passes
        if ($validator->passes()) {
            // Create a new audit area category
            AuditAreaCategory::create([
                'name' => trim($request->name) .' - '. trim($request->category_name),
                'category_name' => trim($request->category_name),
            ]);
            return redirect()->route('audit-categories.index')->with('success', 'Audit Category created successfully.');
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
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
        $auditCategory = AuditAreaCategory::findOrFail($id);
        $categories = AuditAreaCategory::CATEGORIES;
        return inertia('AuditCategories/Edit',[
            'auditCategory' => $auditCategory,
            'categories' => $categories
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {        //
        $auditCategory = AuditAreaCategory::findOrFail($id);
        $validator = Validator::make($request->all(),[
            'name' => 'required|string|max:255',
            'category_name' => 'required|string|max:255|',
        ]);
        // Check if validation passes
        if ($validator->passes()) {                        
            // Update the audit area category
            $auditCategory->update([
                'name' => trim($request->name) .' - '.trim($request->category_name),
                'category_name' => trim($request->category_name),
            ]);
            return redirect()->route('audit-categories.index')->with('success', 'Audit Category updated successfully.');
        } else {
            return response()->json(['errors' => $validator->errors()], 422);
        }
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {        
        $auditCategory = AuditAreaCategory::find($id);                
        if (!$auditCategory || $auditCategory->id != $id) {
            return response()->json(
                ['error' => 'Audit area was not found.'], 
                404
            );
        }
        $auditCategory->delete();
        return response()->json(
            ['success' => 'Audit area deleted successfully.',
            'status' => true
            ], 
            200
        );
    }
}
