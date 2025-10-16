<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\Request;
use League\CommonMark\Reference\Reference;

class ProtocolQuestion extends Model
{
    //
    protected $fillable = [
        'question',
        'critical_element_type_id',
        'pq_number',
        'answer',
        'status',
        'answer_details',
        'pq_category',
        'ce_category',
        'assistance_status',
        'icao_reference',
        'responsible_entity',
        'estimated_completion_date',
        'gap_identified',
        'actual_completion_date',
        'remarks'
    ];

    public const CRITICAL_ELEMENT_TYPES = [       
        ['id'=> 1, 'name'=> 'CE-1'],
        ['id'=> 2, 'name'=> 'CE-2'],
        ['id'=> 3, 'name'=> 'CE-3'],
        ['id'=> 4, 'name'=> 'CE-4'],
        ['id'=> 5, 'name'=> 'CE-5'],
        ['id'=> 6, 'name'=> 'CE-6'],
        ['id'=> 7, 'name'=> 'CE-7'],
        ['id'=> 8, 'name'=> 'CE-8'],                            
    ];

    public function scopeSearch(Builder $query , Request $request){       
        return $query->where(function($query) use ($request){
            return $query->when($request->search,function($query) use ($request){ 
                return $query->where(function ($query) use ($request){
                    $query->where('question','like','%'.$request->search.'%')
                    ->orWhere('status','like','%'.$request->search.'%')
                    ->orWhere('responsible_entity','like','%'.$request->search.'%');
                });
            });
        });
    }


    public static function getCriticalElementIdByName(string $name): ?int
    {
        foreach (self::CRITICAL_ELEMENT_TYPES as $type) {
            if ($type['name'] === $name) {
                return $type['id'];
            }
        }
        return null;
    }

    // Define many to one relationship with ReferenceDocument
    public function referenceDocuments()
    {
        return $this->hasMany(ReferenceDocument::class);        
    }

    public function evidenceDocuments()
    {
        return $this->hasMany(EvidenceDocument::class);        
    }


}
