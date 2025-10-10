<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\QualityControl;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;
use Inertia\Inertia;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;

class QualityControlReportController extends Controller implements HasMiddleware
{
    public static function middleware():array {
        return [
            new Middleware('permission:generate quality control reports', only: ['index','generateQualityControlReport']),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {    
        // Fetch all facilities from the database
        $searchQuery = QualityControl::with(['facility','users'])
            ->whereHas('selectedChecklistQuestions')// Ensure there are selected checklist questions and 
            //->where('status', 'completed') // Only show completed quality controls
            ->search($request);
        $qualityControls =  $searchQuery->orderBy('created_at','desc')->paginate(100);
        // Return the facilities to the view
        return Inertia::render('QualityControlReports/List', [
            'qualityControls' => $qualityControls,
            'search' => $request->search ?? '', 
            'start_date' => $request->start_date ?? '',
            'end_date' => $request->end_date ?? '',
        ]);
    }

    public function generateQualityControlReport(string $id){
        $qualityControl = QualityControl::findOrFail($id);
        $operator = $qualityControl->facility ?? null;
        $selectedChecklistQuestions = $qualityControl->selectedChecklistQuestions()            
            ->get()
            ->groupBy('audit_area_name');
        $users = $qualityControl->users()->get();
        
        $pdf = PDF::loadView('pdfTemplates.qualityControlReport', [
            'qualityControl' => $qualityControl,
            'operator' => $operator,
            'groupedAuditedArea' => $selectedChecklistQuestions,
            'users' => $users
        ])->setPaper('A4', 'portrait');


        return $pdf->download('qualityControl_'.$qualityControl->id.'.pdf');
    }
    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
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
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
