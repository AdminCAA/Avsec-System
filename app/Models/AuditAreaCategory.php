<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class AuditAreaCategory extends Model
{
    //
    public const CATEGORIES = [        
        'Airport Operator',
        'Airline Operator',
        'Regulated Agent',
        'Catering Agent',        
        'Ground Handling Agent',
        'Fuel Supplier',
        'Outsourced Security Service Provider',
        //'Security Agent',
        //'Maintenance Provider',        
        'Air Navigation Service Provider' ,
        'Training Organization',        
    ];

    protected $fillable = [
        'name',
        'category_name',
    ];

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('name','like','%'.$request->search.'%')
                    ->orWhere('category_name','like','%'.$request->search.'%');                    
                });
            });
        });
    }

    public function auditQuestions()
    {
        return $this->hasMany(AuditQuestion::class);
    }

}
