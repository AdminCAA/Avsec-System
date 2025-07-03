<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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
        'Security Agent',
        'Maintenance Provider',        
        'Training Organization',        
    ];

    protected $fillable = [
        'name',
        'category_name',
    ];

    public function auditQuestions()
    {
        return $this->hasMany(AuditQuestion::class);
    }

}
