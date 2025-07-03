<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class Training extends Model
{
    //
    protected $fillable = [
        'title',
        'description',
    ];

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('title','like','%'.$request->search.'%')                    
                    ->orWhere('description','like','%'.$request->search.'%');
                });
            });
        });
    }

    public function users()
    {
        return $this->belongsToMany(User::class)
            ->withPivot('date_taken', 'score', 'type')
            ->withTimestamps();
    }
}
