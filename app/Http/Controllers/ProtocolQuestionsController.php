<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\EvidenceDocument;
use App\Models\ProtocolQuestion;
use Illuminate\Http\Request;
use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;
use App\Models\ReferenceDocument;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\Storage;
use Maatwebsite\Excel\Facades\Excel;
use App\Imports\ProtocolQuestionsImport;
use App\Exports\ProtocolQuestionsTemplateExport;
use App\Services\ActivityLogger;

class ProtocolQuestionsController extends Controller implements HasMiddleware
{    
    protected ActivityLogger $activityLogger;

    public function __construct(ActivityLogger $activityLogger)
    {
        $this->activityLogger = $activityLogger;
    }

    public static function middleware(): array {
        return [
            new Middleware('permission:manage protocol questions', only: [
                'index','create','store','edit','update','destroy',
                'createReference','storeReference','editReference',
                'updateReference','destroyReferenceDocument',
                'createEvidence','storeEvidence','editEvidence',
                'updateEvidence','destroyEvidenceDocument'                
            ] ),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
        $searchQuery = ProtocolQuestion::search($request);
        $protocolQuestions = $searchQuery    
        ->with(['referenceDocuments','evidenceDocuments'])        
        ->orderBy('created_at','DESC')
        //->where('status','Open')
        -> paginate(50);
        return inertia('ProtocolQuestions/List', [
            'protocolQuestions' => $protocolQuestions,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
         // Fetching all critical element types
         $criticalElementTypes = ProtocolQuestion::CRITICAL_ELEMENT_TYPES;      
         return Inertia::render('ProtocolQuestions/Create',
         [
             'criticalElementTypes' => $criticalElementTypes,
         ]);
    }


    public function createReference(string $id)
    {
         // Fetching all critical element types
         $protocolQuestion = ProtocolQuestion::findOrFail($id);    
         return Inertia::render('ProtocolQuestions/CreateReference',
         [
             'protocolQuestion' => $protocolQuestion,
         ]);
    }

    public function createEvidence(string $id)
    {
         // Fetching all critical element types
         $protocolQuestion = ProtocolQuestion::findOrFail($id);    
         return Inertia::render('ProtocolQuestions/CreateEvidence',
         [
             'protocolQuestion' => $protocolQuestion,
         ]);
    }

    public function editReference(string $id){
        $referenceDocument = ReferenceDocument::findOrFail($id);    
        return Inertia::render('ProtocolQuestions/EditReference',
        [
            'referenceDocument' => $referenceDocument,
        ]);
    }    

    public function editEvidence(string $id){
        $evidenceDocument = EvidenceDocument::findOrFail($id);    
        return Inertia::render('ProtocolQuestions/EditEvidence',
        [
            'evidenceDocument' => $evidenceDocument,
        ]);
    }

    public function storeEvidence(Request $request, string $id)
    {
        $validator = Validator::make($request->all(),[            
            'name' => 'required|string',                                                               
            'protocol_question_id' => 'required|exists:protocol_questions,id',
            'doc_page' => 'nullable|integer',            
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,gif,pdf,doc,docx,xls,xlsx|max:5120'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Find the protocol question
        $protocolQuestion = ProtocolQuestion::findOrFail($id);
        // Create a new reference
        $protocolQuestion->evidenceDocuments()->create([
            'name' => $request->name,
            'file_name'=> trim($request->name),
            'doc_page' => trim($request->doc_page),            
            'protocol_question_id' => $request->protocol_question_id,
            'attachment' => $request->hasFile('attachment') ? 
                $request->file('attachment')->store('PQ_Evidences', 'public') : 
                null,
            'uploaded_by' => Auth::user()->name,
        ]);

        $this->activityLogger->info('Created Protocol Evidence',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('protocolquestions.edit',$protocolQuestion->id)->with('success', 'Reference document added successfully.');                
    }

    public function storeReference(Request $request, string $id)
    {
        $validator = Validator::make($request->all(),[            
           'name' => 'required|string',                                                               
            'protocol_question_id' => 'required|exists:protocol_questions,id',
            'doc_page' => 'nullable|integer',            
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,gif,pdf,doc,docx,xls,xlsx|max:5120'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Find the protocol question
        $protocolQuestion = ProtocolQuestion::findOrFail($id);
        // Create a new reference
        $protocolQuestion->referenceDocuments()->create([
            'name' => $request->name,
            'file_name'=> trim($request->name),
            'doc_page' => trim($request->doc_page),            
            'protocol_question_id' => $request->protocol_question_id,
            'attachment' => $request->hasFile('attachment') ? 
                $request->file('attachment')->store('PQ_References', 'public') : 
                null,
            'uploaded_by' => Auth::user()->name,
        ]);

        $this->activityLogger->info('Created Protocol Reference',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('protocolquestions.edit',$protocolQuestion->id)->with('success', 'Reference document added successfully.');                
    }

    public function updateReference(Request $request, string $id)
    {
        $validator = Validator::make($request->all(),[            
            'name' => 'required|string',                                                               
            'protocol_question_id' => 'required|exists:protocol_questions,id',
            'doc_page' => 'nullable|integer',            
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,gif,pdf,doc,docx,xls,xlsx|max:5120'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Find the protocol question
        $referenceDocument = ReferenceDocument::findOrFail($id);
        // Update a the reference
        $referenceDocument->name = $request->name;
        $referenceDocument->file_name = trim($request->name);
        $referenceDocument->doc_page = trim($request->doc_page);
        $referenceDocument->protocol_question_id = $request->protocol_question_id;
        $referenceDocument->save();
        if ($request->hasFile('attachment')) {
            if ($referenceDocument->attachment && Storage::disk('public')->exists($referenceDocument->attachment)) {
                Storage::disk('public')->delete($referenceDocument->attachment);
            }
            $attachmentPath = $request->file('attachment')->store('attachment', 'public');
            $referenceDocument->update(['attachment' => $attachmentPath]);
        }    

        $this->activityLogger->info('Updated Protocol Reference',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('protocolquestions.edit',$referenceDocument->protocol_question_id)->with('success', 'Reference document added successfully.');                
    }

    public function updateEvidence(Request $request, string $id)
    {
        $validator = Validator::make($request->all(),[            
            'name' => 'required|string',                                                               
            'protocol_question_id' => 'required|exists:protocol_questions,id',
            'doc_page' => 'nullable|integer',            
            'attachment' => 'nullable|file|mimes:jpg,jpeg,png,gif,pdf,doc,docx,xls,xlsx|max:5120'
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        // Find the protocol question
        $evidenceDocument = EvidenceDocument::findOrFail($id);
        // Update a the reference
        $evidenceDocument->name = $request->name;
        $evidenceDocument->file_name = trim($request->name);
        $evidenceDocument->doc_page = trim($request->doc_page);
        $evidenceDocument->protocol_question_id = $request->protocol_question_id;
        $evidenceDocument->save();
        if ($request->hasFile('attachment')) {
            if ($evidenceDocument->attachment && Storage::disk('public')->exists($evidenceDocument->attachment)) {
                Storage::disk('public')->delete($evidenceDocument->attachment);
            }
            $attachmentPath = $request->file('attachment')->store('attachment', 'public');
            $evidenceDocument->update(['attachment' => $attachmentPath]);
        } 
        
        $this->activityLogger->info('Updated Protocol Evidence',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('protocolquestions.edit',$evidenceDocument->protocol_question_id)->with('success', 'Evidence document added successfully.');                
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {        
        $validator = Validator::make($request->all(),[            
            'question' => 'required|string',
            'pq_number' => 'nullable|string|max:60',                                                
            'ce_category' => 'nullable|string|max:60',            
            'icao_reference' => 'nullable|string|max:60',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        ProtocolQuestion::create([
            'question' => $request->question,
            'critical_element_type_id' => ProtocolQuestion::getCriticalElementIdByName($request->ce_category),
            'pq_number' => $request->pq_number,                        
            'ce_category' => $request->ce_category,            
            'icao_reference' => $request->icao_reference,
        ]);

        $this->activityLogger->info('Created Protocol Question',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        return redirect()->route('protocolquestions.index')->with('success', 'Protocol Question created successfully.');
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
        $protocolQuestion = ProtocolQuestion:: 
         with(['referenceDocuments','evidenceDocuments'])->findOrFail($id);
        $criticalElementTypes = ProtocolQuestion::CRITICAL_ELEMENT_TYPES;  
        return Inertia::render('ProtocolQuestions/Edit', [
            'protocolQuestion' => $protocolQuestion,
            'criticalElementTypes' => $criticalElementTypes,
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $protocolQuestion = ProtocolQuestion::findOrFail($id);
        $validator = Validator::make($request->all(),[            
            'question' => 'required|string',
            'pq_number' => 'nullable|string|max:60',                                                
            'ce_category' => 'nullable|string|max:60',            
            'icao_reference' => 'nullable|string|max:60',
        ]);
        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        $protocolQuestion->update([
            'question' => $request->question,
            'critical_element_type_id' => ProtocolQuestion::getCriticalElementIdByName($request->ce_category),            
            'pq_number' => $request->pq_number,                        
            'ce_category' => $request->ce_category,            
            'icao_reference' => $request->icao_reference,                            
            'answer'=> $request->answer,
            'status'=> $request->status,
            'answer_details'=> $request->answer_details,
            'pq_category'=> null,
            'assistance_status'=> $request->assistance_status,        
            'responsible_entity'=> $request->responsible_entity,
            'estimated_completion_date'=> $request->estimated_completion_date,
            'gap_identified'=> $request->gap_identified,
            'actual_completion_date'=> $request->actual_completion_date,
            'remarks'=> $request->remarks,
        ]);

        $this->activityLogger->info('Edited Protocol Question',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {        
        $protocolQuestion = ProtocolQuestion::findOrFail($id);        
        // Delete the protocol question record

        //Handle file deletion for reference documents
        foreach ($protocolQuestion->referenceDocuments as $referenceDocument) {
            if ($referenceDocument->attachment && Storage::disk('public')->exists($referenceDocument->attachment)) {
                Storage::disk('public')->delete($referenceDocument->attachment);
            }
        }

        //Handle file deletion for evidence documents
        foreach ($protocolQuestion->evidenceDocuments as $evidenceDocument) {
            if ($evidenceDocument->attachment && Storage::disk('public')->exists($evidenceDocument->attachment)) {
                Storage::disk('public')->delete($evidenceDocument->attachment);
            }
        }

        $protocolQuestion->delete();

        $this->activityLogger->warning('Deleted Protocol Question',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
        // Redirect to the protocol question list with a success message
        return response()->json(
            ['success' => 'Protocol Question deleted successfully.',
            'status' => true
            ], 
            200
        );          
    }

    public function destroyReferenceDocument(string $id)
    {        
        $referenceDocument = ReferenceDocument::findOrFail($id);                
        //Handle file deletion if exists
        if ($referenceDocument->attachment && Storage::disk('public')->exists($referenceDocument->attachment)) {
            Storage::disk('public')->delete($referenceDocument->attachment);
        }
        // Delete the protocol question record
        $referenceDocument->delete();

        $this->activityLogger->warning('Deleted Protocol Reference',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
        
        // Redirect to the protocol question list with a success message
        return response()->json(
            ['success' => 'Reference Document deleted successfully.',
            'status' => true
            ], 
            200
        );          
    }

    public function destroyEvidenceDocument(string $id)
    {        
        $evidenceDocument = EvidenceDocument::findOrFail($id);                
        //Handle file deletion if exists
        if ($evidenceDocument->attachment && Storage::disk('public')->exists($evidenceDocument->attachment)) {
            Storage::disk('public')->delete($evidenceDocument->attachment);
        }
        // Delete the protocol question record
        $evidenceDocument->delete();

        $this->activityLogger->warning('Deleted Protocol Evidence',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);

        // Redirect to the protocol question list with a success message
        return response()->json(
            ['success' => 'Evidence Document deleted successfully.',
            'status' => true
            ], 
            200
        );          
    }

    public function exportPDF()
    {
        $protocolQuestions = ProtocolQuestion::with(['referenceDocuments', 'evidenceDocuments'])->get();

        $pdf = Pdf::loadView('pdfTemplates.protocolQuestions', compact('protocolQuestions'))
            ->setPaper('a4', 'landscape');


        $this->activityLogger->info('Downloaded Protocol Question PDF',[
            'User Name' => Auth::user()->name,
            'User Role'=> Auth::user()->roles->pluck('name')->join(', '),
            'IP'=> request()->ip(),
            'Time' => now(),
        ]);
            
        return $pdf->download('protocol_questions.pdf');
    }

    public function downloadTemplate()
    {
        return Excel::download(new ProtocolQuestionsTemplateExport, 'protocol_questions_template.xlsx');
    }

    public function importProtocolQuestions(Request $request)
    {
        $request->validate([
            'file' => 'required|mimes:xlsx,xls',
        ]);

        try {
            Excel::import(new ProtocolQuestionsImport, $request->file('file'));
        } catch (\Maatwebsite\Excel\Validators\ValidationException $e) {
            $failures = $e->failures();
            return redirect()->back()->with('error', 'Import failed. Check your Excel format.');
        }

        return redirect()->route('protocolquestions.index')
                        ->with('success', 'Protocol Questions imported successfully!');
    }







}
