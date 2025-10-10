<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\AuditAreaCategory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\AuditQuestion;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class AuditQuestionController extends Controller implements HasMiddleware
{
    /**
     * Define middleware for the controller.
     */
    public static function middleware(): array {
        return [
            new Middleware('permission:manage checklist questions', only: ['index','create','store','edit','update','destroy']),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
        $searchQuery = AuditQuestion::search($request);
        $auditQuestions = $searchQuery->with('auditAreaCategory')->orderBy('created_at','ASC')-> paginate(50);
        return inertia('AuditQuestions/List', [
            'auditQuestions' => $auditQuestions,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        // Fetching all audit area categories
        $auditAreaCategories = AuditAreaCategory::all();        
        return inertia('AuditQuestions/Create',
        [
            'auditCategories' => $auditAreaCategories,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator::make($request->all(), [
            'audit_area_category_id' => 'required|exists:audit_area_categories,id',
            'question' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }
        $auditAreaCategory = AuditAreaCategory::find($request->audit_area_category_id);

        if (!$auditAreaCategory) {
            return response()->json(['message' => 'Audit area category not found'], 404);
        }

        // Create a new audit question
        AuditQuestion::create([
            'audit_area_category_id' => $request->audit_area_category_id,
            'question' => trim($request->question),
            'audit_area_name'=> trim($auditAreaCategory->name),
        ]);
        return redirect()->route('audit-questions.index')->with('success', 'Audit question created successfully.');
      
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
        $auditQuestion = AuditQuestion::findOrFail($id);
        $auditAreaCategories = AuditAreaCategory::all();    
        return inertia('AuditQuestions/Edit', [
            'auditQuestion' => $auditQuestion,
            'auditCategories' => $auditAreaCategories,
        ]);  
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $auditQuestion = AuditQuestion::findOrFail($id);
        $validator = Validator::make($request->all(), [
            'audit_area_category_id' => 'required|exists:audit_area_categories,id',
            'question' => 'required|string|unique:audit_questions,question,'.$auditQuestion->id .',id',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $auditAreaCategory = AuditAreaCategory::find($request->audit_area_category_id);
        // Update the audit question
        $auditQuestion->update([
            'audit_area_category_id' => $request->audit_area_category_id,
            'question' => trim($request->question),
            'audit_area_name'=> trim($auditAreaCategory->name),
        ]);
        return redirect()->route('audit-questions.index')->with('success', 'Audit question updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //Retrieve the audit question by ID
        $auditQuestion = AuditQuestion::find($id);
        // Check if the audit question exists
        if (!$auditQuestion || $auditQuestion->id != $id) {
            return response()->json(['message' => 'Audit question not found'], 404);
        }
        // Delete the audit question
        $auditQuestion->delete();
        // Return a success response
        return response()->json(['message' => 'Audit question deleted successfully'], 200);
    }
}
