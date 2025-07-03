<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class AuditQuestion extends Model
{
    //
    protected $fillable = [
        'audit_area_category_id',
        'question',
        'audit_area_name'
    ];
    
    public function auditAreaCategory()
    {
        return $this->belongsTo(AuditAreaCategory::class);
    }

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('question','like','%'.$request->search.'%');
                });
            });
        });
    }
}
