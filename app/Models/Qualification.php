<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Qualification extends Model
{
    //
    protected $fillable = [
        'user_id',
        'qualification_type', // e.g., 'Degree', 'Certification', etc.
        'qualification_name',  // Name of the qualification
        'institution',         // Institution name (optional)
        'date_obtained',       // Date when qualification was obtained
        'qualification_number',
        'qualification_file'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

}
