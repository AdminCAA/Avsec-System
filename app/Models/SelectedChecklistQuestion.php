<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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
        'date_of_closure',
        'status'
    ];

    public function qualityControl()
    {
        return $this->belongsTo(QualityControl::class);
    }

}
