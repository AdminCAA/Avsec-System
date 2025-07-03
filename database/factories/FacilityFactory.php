<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Facility;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Facility>
 */
class FacilityFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    protected $model = Facility::class;
    public function definition(): array
    {
        return [
            
            'name' => $this->faker->company,
            'description' => $this->faker->sentence,
            'category' => $this->faker->randomElement([
                'Airport Operator',
                'Airline Operator',
                'Regulated Agent',
                'Catering Agent',        
                'Ground Handling Agent',
                'Fuel Supplier',
                'Security Agent',
                'Maintenance Provider',        
                'Training Organization',   
            ]),
            'location' => $this->faker->city,
            'address' => $this->faker->address,
            'contact_number' => $this->faker->phoneNumber,
            'email' => $this->faker->unique()->safeEmail,            
        ];
    }
}
