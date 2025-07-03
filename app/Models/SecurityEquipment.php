<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;

class SecurityEquipment extends Model
{
    //    
    protected $fillable = [
        'name','status','facility_id','serial_number','description','facility_name'
    ];

    public const STATUSES = [        
        'Active',
        'Inactive',
        'Under Maintenance',
        'Due for Maintenance',
        'Decommissioned',             
    ];

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('name','like','%'.$request->search.'%')
                    ->orWhere('facility_name','like','%'.$request->search.'%') 
                    ->orWhere('status','like','%'.$request->search.'%');                    
                });
            });
        });
    }

    public function facility()
    {
        return $this-> belongsTo(Facility::class);
    }

    public function maintenanceSchedules()
    {
        return $this->hasMany(MaintenanceSchedule::class);
    }
}
