<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;



class Facility extends Model
{
    //
    use HasFactory;
    protected $fillable = [
        'name',
        'description',
        'category',
        'location',
        'address',
        'contact_number',
        'email',
    ];

    public const CATEGORIES = [        
        'Airport Operator',
        'Airline Operator',
        'Regulated Agent',
        'Catering Agent',        
        'Ground Handling Agent',
        'Fuel Supplier',
        'Security Agent',
        'Maintenance Provider',        
        'Training Organization',        
    ];

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('name','like','%'.$request->search.'%')
                    ->orWhere('category','like','%'.$request->search.'%')
                    ->orWhere('location','like','%'.$request->search.'%');
                });
            });
        });
    }

    public function qualityControls()
    {
        return $this->hasMany(QualityControl::class);
    }

    public function securityEquipments()
    {
        return $this->hasMany(SecurityEquipment::class);
    }

    public function users()
    {
        return $this->hasMany(User::class);
    }    
}
