<?php

namespace App\Models;

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
        'status',
    ];

    public const CONTROL_TYPE = [        
        'Audit',
        'Inspection',
        'Security Test',        
    ];

    public const STATUSES = [
        'Pending',        
        'In Progress',
        'Completed',                
        'Overdue',  
        'Follow Up Required',        
        'Closed',
    ];


    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('title','like','%'.$request->search.'%')
                    ->orWhere('status','like','%'.$request->search.'%')
                    ->orWhere('description','like','%'.$request->search.'%');
                });
            });
        });
    }

    public function facility()
    {
        return $this->belongsTo(Facility::class);
    }

    public function selectedchecklistQuestions(){
        return $this->hasMany(SelectedChecklistQuestion::class);
    }

    public function qualityControlAlerts()
    {
        return $this->hasMany(QualityControlAlert::class);
    }
    
}
