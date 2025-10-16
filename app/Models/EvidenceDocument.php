<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class EvidenceDocument extends Model
{
    //

    protected $fillable = [
        'name',
        'protocol_question_id',
        'doc_page',
        'file_name',
        'file_path',
        'uploaded_by',                
        'attachment'
    ];

    public function protocolQuestion()
    {
        return $this->belongsTo(ProtocolQuestion::class);
    }
}
