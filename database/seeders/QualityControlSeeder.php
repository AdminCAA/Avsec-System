<?php
namespace Database\Seeders;
use Illuminate\Database\Seeder;
use App\Models\QualityControl;
use Illuminate\Support\Str;
use Carbon\Carbon;

class QualityControlSeeder extends Seeder
{
    public function run()
    {
        $controlTypes = QualityControl::CONTROL_TYPE;
        $statuses = QualityControl::STATUSES;

        for ($i = 0; $i < 150; $i++) {
            QualityControl::create([
                'facility_id' => rand(1, 104),
                'title' => Str::title(fake()->words(rand(3, 6), true)),
                'control_type' => $controlTypes[array_rand($controlTypes)],
                'description' => fake()->paragraph(),
                'scheduled_date' => Carbon::now()->addDays(rand(-10, 30)),
                'status' => $statuses[array_rand($statuses)],
            ]);
        }
    }
}
