<?php

namespace App\Imports;

use App\Models\ProtocolQuestion;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;

class ProtocolQuestionsImport implements ToModel, WithHeadingRow
{
    /**
    * @param array $row
    *
    * @return \Illuminate\Database\Eloquent\Model|null
    */

    public function model(array $row)
{
    if (empty($row['question'])) {
        return null; // skip rows with empty question
    }

    return new ProtocolQuestion([
        'question' => $row['question'],
        'pq_number' => $row['pq_number'] ?? null,
        'ce_category' => $row['ce_category'] ?? null,
        'icao_reference' => $row['icao_reference'] ?? null,
        //'critical_element_type_id' => ProtocolQuestion::getCriticalElementIdByName($row['ce_category'] ?? null),
    ]);
}


}
