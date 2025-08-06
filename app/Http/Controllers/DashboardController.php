<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Facility;
use App\Models\QualityControl;
use App\Models\SelectedChecklistQuestion;
use Inertia\Inertia;

use function Pest\Laravel\json;

class DashboardController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        return Inertia::render('Dashboard', [
            'stats' => $this->getDashboardStats()
        ]);
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

    public function getDashboardStats(){
        //Get Operators statistics
        $operators = Facility::all();
        $operatorType = $operators->groupBy('category')->reject(function ($controls, $category) {
            return $category === 'Regulatory Authority';
        })->map(function ($controls) {
            return $controls->count();
        });


        $operatorsStats = Facility::whereHas('qualityControls.selectedchecklistQuestions')
            ->withCount([
                // Count all quality controls (regardless of status)
                'qualityControls as quality_control_count' => function ($query) {
                    $query->whereHas('selectedchecklistQuestions');
                }
            ])
            ->with([
                'qualityControls' => function ($query) {
                    $query->whereHas('selectedchecklistQuestions')
                        ->with(['selectedchecklistQuestions'])
                            ->withCount([
                                // Open questions count
                                'selectedchecklistQuestions as open_questions_count' => function ($q) {
                                    $q->where('status', 'Open');
                                },
                                // Overdue questions count
                                'selectedchecklistQuestions as overdue_questions_count' => function ($q) {
                                    $q->where('status', 'Overdue');
                                },
                                // Closed questions count
                                'selectedchecklistQuestions as closed_questions_count' => function ($q) {
                                    $q->where('status', 'Closed');
                                },
                            ]);
                    }
                ])
        ->get();
        // Aggregate all the quality control data for each operator
        $result = $operatorsStats->map(function ($facility) {
            $totalOpen = $facility->qualityControls->sum('open_questions_count');
            $totalOverdue = $facility->qualityControls->sum('overdue_questions_count');
            $totalClosed = $facility->qualityControls->sum('closed_questions_count');        
            return [
                'operator_name' => $facility->name,
                'quality_control_count' => $facility->quality_control_count,
                'total_open_questions' => $totalOpen,
                'total_overdue_questions' => $totalOverdue,
                'total_security' => $totalOpen + $totalOverdue ,
                'total_closed_questions' => $totalClosed,
            ];
        });
               

        $selectedChecklistQuestions = SelectedChecklistQuestion::all();
        $openSecurityConcerns = $selectedChecklistQuestions->where('status', 'Open')->count();
        $overdueSecurityConcerns = $selectedChecklistQuestions->where('status', 'Overdue')->count();
        $closedSecurityConcerns = $selectedChecklistQuestions->where('status', 'Closed')->count();
        $totalSecurityConcerns = $selectedChecklistQuestions->count();            
        
        // Get all quality controls
        $qualityControls = QualityControl::all();
        
        $audits = $qualityControls->where('control_type', 'Audit')->count();
        $inspections = $qualityControls->where('control_type', 'Inspection')->count();
        $securityTests = $qualityControls->where('control_type', 'Security Test')->count();
        $totalQualityControls = $qualityControls->count();          
        
        $pendingQualityControls = $qualityControls->where('status', 'Pending')->count();
        $inProgressQualityControls = $qualityControls->where('status', 'In Progress')->count();
        $completedQualityControls = $qualityControls->where('status', 'Completed')->count();
        $overdueQualityControls = $qualityControls->where('status', 'Overdue')->count();

        return [                                                           
            'totalAudits' => $audits,
            'totalInspections' => $inspections,
            'totalSecurityTests' => $securityTests,
            'totalQualityControls' => $totalQualityControls,
            'openSecurityConcerns' => $openSecurityConcerns,
            'overdueSecurityConcerns' => $overdueSecurityConcerns,
            'closedSecurityConcerns' => $closedSecurityConcerns,
            'totalSecurityConcerns' => $totalSecurityConcerns,
            'operators' => $operatorType,
            'totalOperators' => $operators->count(),
            
            'pendingQualityControls' => $pendingQualityControls,
            'inProgressQualityControls' => $inProgressQualityControls,
            'completedQualityControls' => $completedQualityControls,
            'overdueQualityControls' => $overdueQualityControls,

            'operatorStats'=> $result, // Quality control stats for each operator
            
        ]; 
    }
}
