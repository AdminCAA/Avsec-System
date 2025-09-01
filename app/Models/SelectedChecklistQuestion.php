<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class SelectedChecklistQuestion extends Model
{
    
    protected $fillable = [
        'quality_control_id',
        'question',
        'audit_question_id',
        'question_response',
        'date_quality_control',
        'audit_area_name',
        'finding_observation',
        'finding_category',
        'action_taken',
        'problem_cause',
        'short_term_action',
        'long_term_action',
        'completion_date',
        'follow_up_date',
        'proposed_follow_up_action',
        'immediate_corrective_action',
        'recommendations',
        'reference',
        'short_term_date',
        'long_term_date',
        'date_of_closure',
        'status',
        'evidence_file',
        'cap_file',
        'cap_status',
        'reason_for_rejection'
    ];

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('question','like','%'.$request->search.'%')
                    ->orWhere('status','like','%'.$request->search.'%')
                    ->orWhere('finding_category','like','%'.$request->search.'%');
                });
            });
        });
    }

    public function qualityControl()
    {
        return $this->belongsTo(QualityControl::class);
    }

    public function followups(){
        return $this->hasMany(FollowUp::class);
    }

}
