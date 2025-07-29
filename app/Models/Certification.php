<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Certification extends Model
{
    //
    protected $fillable = [
        'user_id',
        'certification_type', // e.g., 'Certification', 'License', etc.
        'certification_name',  // Name of the certification
        'certification_body', // Body that issued the certification
        'date_issued',         // Date when the certification was issued
        'expiry_date',         // Expiry date of the certification
        'certification_number', // Unique number for the certification
        'status',              // Status of the certification (e.g., active, expired, revoked)
        'score',               // Score or grade obtained in the certification, if applicable
        'remarks',             // Additional remarks or comments about the certification 
        'certification_file',  // File path for the certification document, if applicable       
    ];
}
