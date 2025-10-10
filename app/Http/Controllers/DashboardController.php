<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Facility;
use App\Models\QualityControl;
use App\Models\SelectedChecklistQuestion;
use Carbon\Carbon;
use Inertia\Inertia;
use Illuminate\Support\Facades\Auth;

use Illuminate\Routing\Controllers\HasMiddleware;
use Illuminate\Routing\Controllers\Middleware;


class DashboardController extends Controller implements HasMiddleware
{
    public static function middleware():array {
        return [
            new Middleware('permission:view admin dashboard', only: ['index']),
            //new Middleware('permission:view admin dashboard', only: ['index']),
        ];
    }

    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');
        return Inertia::render('Dashboard', [
            'stats' => $this->getDashboardStats($startDate, $endDate),
        ]);
    }

    /**
     * Get dashboard statistics.
     *
     * @param string|null $startDate
     * @param string|null $endDate
     * @return array
     */

    public function getDashboardStats($startDate = null, $endDate = null){
        $user = Auth::user();
        $startDate = $startDate ? Carbon::parse($startDate)->startOfDay() : null;
        $endDate   = $endDate ? Carbon::parse($endDate)->endOfDay() : null;

        // Helper for applying date filter on QualityControls
        $dateFilter = function ($query) use ($startDate, $endDate) {
            if ($startDate && $endDate) {
                $query->whereBetween('scheduled_date', [$startDate, $endDate]);
            } elseif ($startDate) {
                $query->where('scheduled_date', '>=', $startDate);
            } elseif ($endDate) {
                $query->where('scheduled_date', '<=', $endDate);
            }
        };
        


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
                'qualityControls as quality_control_count' => function ($query) use ($dateFilter) {
                    $query->whereHas('selectedchecklistQuestions')->where($dateFilter);
                }
            ])
            ->with([
                'qualityControls' => function ($query) use ($dateFilter) {
                    $query->whereHas('selectedchecklistQuestions')
                        ->where($dateFilter)
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
               
        $userId = Auth::id();
        $selectedChecklistQuestions = SelectedChecklistQuestion::whereHas('qualityControl', $dateFilter)->get();
        if ($user->hasAnyRole(['Administrator', 'AVSEC Administrator', 'Super Admin'])) {
            
        }else{
            $selectedChecklistQuestions = SelectedChecklistQuestion::
                whereHas('qualityControl.users', function ($query) use ($user) {
                    $query->where('users.id', $user->id);
                })->whereHas('qualityControl', $dateFilter)->get();                
        }
        
        $openSecurityConcerns = $selectedChecklistQuestions->where('status', 'Open')->count();
        $overdueSecurityConcerns = $selectedChecklistQuestions->where('status', 'Overdue')->count();
        $closedSecurityConcerns = $selectedChecklistQuestions->where('status', 'Closed')->count();
                
        $totalSecurityConcerns = $selectedChecklistQuestions->whereIn('status', ['Open', 'Overdue'])->count();
        // Get all quality controls
        $qualityControls = QualityControl::where($dateFilter)->get();
        if ($user->hasAnyRole(['Administrator', 'AVSEC Administrator', 'Super Admin'])) {

        }else{
            $qualityControls = QualityControl::where($dateFilter)
                ->whereHas('users', function ($query) use ($user) {
                    $query->where('users.id', $user->id);
                })->get();
        }
                
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
