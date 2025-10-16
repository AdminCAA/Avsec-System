<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MandatoryCourse extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'course_name',
        'training_center',
        'certificate_number',
        'date_issued',
        'expiry_date',
        'status',
        'attachment',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
