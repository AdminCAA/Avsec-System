<?php

namespace App\Exports;


use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;

class ProtocolQuestionsTemplateExport implements FromArray, WithHeadings
{
 
    public function array(): array
    {
        return [];
    }

    public function headings(): array
    {
        return [
            'question',
            'pq_number',
            'ce_category',
            'icao_reference',
        ];
    }

}
