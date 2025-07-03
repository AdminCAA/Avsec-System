<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class MaintenanceSchedule extends Model
{
    //
    protected $fillable = [
        'security_equipment_id',
        'last_performed_date',
        'next_due_date',
        'maintenance_type',
        'status',
        'assigned_to',
        'frequency',
        'description'
    ];

    public function securityEquipment()
    {
        return $this->belongsTo(SecurityEquipment::class);
    }   
    
}
