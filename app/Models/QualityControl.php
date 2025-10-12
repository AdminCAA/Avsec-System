<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class QualityControl extends Model
{
    //
    protected $fillable = [
        'facility_id',
        'title',
        'control_type',        
        'description',
        'scheduled_date',
        'end_date', 
        'status',
        'approval_status',
        'user_id',
        'department_id',
        'department_name',
    ];

    public const CONTROL_TYPE = [        
        'Audit',
        'Inspection',
        'Security Test',  
        'Document Approval'      
    ];

    public const STATUSES = [
        'Pending',        
        'In Progress',
        'Completed',                
        'Overdue',           
        'Closed',
    ];


    public function scopeSearch(Builder $query , Request $request){               
        // return $query->where(function($query) use ($request){           
        //     return $query->when($request->search,function($query) use ($request){ 
        //         return $query->where(function ($query) use ($request){
        //             $query->where('title','like','%'.$request->search.'%')
        //             ->orWhere('status','like','%'.$request->search.'%')
        //             ->orWhere('description','like','%'.$request->search.'%');
        //         });
        //     });                     
        // });

         // Search text
        $query->when($request->search, function ($query) use ($request) {
            $query->where(function ($query) use ($request) {
                $query->where('title', 'like', '%' . $request->search . '%')
                    ->orWhere('status', 'like', '%' . $request->search . '%')
                    ->orWhere('description', 'like', '%' . $request->search . '%');
            });
        });

            // Filter by start_date (scheduled_date >= start_date)
        $query->when($request->start_date, function ($query) use ($request) {
            $query->whereDate('scheduled_date', '>=', Carbon::parse($request->start_date));
        });

        // Filter by end_date (end_date <= end_date)
        $query->when($request->end_date, function ($query) use ($request) {
            $query->whereDate('end_date', '<=', Carbon::parse($request->end_date));
        });

        return $query;
    }

    public function facility()
    {
        return $this->belongsTo(Facility::class);
    }

    public function department()
    {
        return $this->belongsTo(Department::class);
    }   

    public function selectedchecklistQuestions(){
        return $this->hasMany(SelectedChecklistQuestion::class);
    }

    public function qualityControlAlerts()
    {
        return $this->hasMany(QualityControlAlert::class);
    }
    
    public function users()
    {
        return $this->belongsToMany(User::class)->withTimestamps();
    }  
    
    public function approvers()
    {
        return $this->belongsToMany(User::class,'approvers_quality_controls')->withTimestamps();
    }
}
