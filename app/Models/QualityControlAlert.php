<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class QualityControlAlert extends Model
{
    //
    protected $fillable = [
        'quality_control_id',
        'source_alert_id',
        'source_alert_name',        
        'alert_type', //'Overdue', 'Follow Up Required', etc.
        'alert_description',
        'alert_status', // Status of the alert (e.g., 'Active', 'Resolved')
        'alert_resolved_date',
        'alert_date', // Date when the alert was generated        
    ];

    public function qualityControl()
    {
        return $this->belongsTo(QualityControl::class);
    }
    

}
