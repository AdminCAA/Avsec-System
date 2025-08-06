<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class FollowUp extends Model
{
    //
    protected $fillable  = [
        'user_id',
        'title',
        'user_name',
        'selected_checklist_question_id',
        'followup_comments',
        'followup_date'
    ];

    public function SelectedChecklistQuestion(){
        return $this->belongsTo(SelectedChecklistQuestion::class);
    }  
    public function user(){
        return $this->belongsTo(User::class);
    }  
}
