<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Facility;
use App\Models\SecurityEquipment;
use Illuminate\Support\Str;

class SecurityEquipmentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = \Faker\Factory::create();
        $statuses = [ 
            'Active',
            'Inactive',
            'Under Maintenance',
            'Due for Maintenance',
            'Decommissioned', 
        ];
        
        $equipmentList = [
            'Walk-Through Metal Detector' => 'Detects concealed metal objects on persons passing through.',
            'Handheld Metal Detector' => 'Used for secondary screening of passengers.',
            'X-ray Baggage Scanner' => 'Scans luggage and carry-on bags for prohibited items.',
            'Explosive Trace Detector' => 'Identifies trace amounts of explosives on surfaces or belongings.',
            'Biometric Access Terminal' => 'Controls access using fingerprint or retina scan authentication.',
            'Surveillance Camera (CCTV)' => 'Monitors activity within the facility perimeter.',
            'Full-Body Scanner' => 'Scans passengers for concealed threats or contraband.',
            'Under Vehicle Surveillance System' => 'Inspects the underside of vehicles entering restricted zones.',
            'Perimeter Intrusion Detection System' => 'Alerts security on unauthorized perimeter breaches.',
            'Access Control Panel' => 'Manages and logs secure access to restricted areas.',
            'Baggage Conveyor Scanner' => 'Integrated conveyor belt system with real-time X-ray imaging.',
            'Facial Recognition Terminal' => 'Automated identity verification using facial features.',
            'Vehicle Barrier / Bollard' => 'Stops unauthorized vehicle entry.',
            'Automated License Plate Recognition (ALPR)' => 'Reads and verifies license plates automatically.',
            'Radiation Detection Portal' => 'Detects radioactive materials passing through.',
            'Emergency Communication System' => 'Two-way communication system for emergency response.',
            'Security Intercom' => 'Entry point audio/video communication device.',
            'Explosive Detection System (EDS)' => 'Advanced detection system for explosives in baggage.',
            'Sniffer Dog Kennel / Deployment Point' => 'Designated area for explosive detection dog teams.',
            'Bullet-Resistant Guard Booth' => 'Protected space for on-site security personnel.',
            'Drone Detection System' => 'Identifies and alerts on unauthorized drone activity.',
            'TSA Approved Screening Table' => 'Standard table for manual screening of carry-ons.',
            'Digital Evidence Recording System' => 'Captures and stores video/audio evidence securely.',
            'Metal Detection Archway with Counting System' => 'Metal detector with integrated people counter.',
            'Infrared Thermal Scanner' => 'Detects elevated body temperature remotely.'
        ];


        Facility::all()->each(function ($facility) use ($statuses, $equipmentList, $faker) {
            $count = rand(3, 6);
            $keys = array_keys($equipmentList);

            for ($i = 0; $i < $count; $i++) {
                $name = $keys[array_rand($keys)];
                SecurityEquipment::create([
                    'facility_id' => $facility->id,
                    'name' => $name,
                    'facility_name'=>$facility->name,
                    'serial_number' => Str::upper(Str::random(8)) . '-' . $faker->unique()->randomNumber(5),
                    'status' => $statuses[array_rand($statuses)],
                    'description' => $equipmentList[$name],
                ]);
            }
        });
    }
}
