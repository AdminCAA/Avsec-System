<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\Facility;
use App\Models\MaintenanceSchedule;
use App\Models\SecurityEquipment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class SecurityEquipmentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        //
         // Fetch all facilities from the database
         $searchQuery = SecurityEquipment::search($request);
         $securityEquipments =  $searchQuery->orderBy('name','asc')->paginate(50);
         // Return the facilities to the view
         return Inertia::render('SecurityEquipments/List', [
             'securityEquipments' => $securityEquipments,
             'search' => $request->search ?? '',
         ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        $statuses = SecurityEquipment::STATUSES;
        $facilities = Facility::all();
        //
        return Inertia::render(
            'SecurityEquipments/Create',
            [
                'facilities'=>$facilities,
                'statuses' => $statuses
            ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $validator = Validator::make($request->all(),
            [
                'name' => 'required|string|max:255',
                'facility_id' => 'required|integer|exists:facilities,id',
                'description' => 'nullable|string|max:1000',
                'status' => 'required|string|max:255',           
            ]
        );
        // Check if validation passes
        if($validator->passes()){
            // Create a new facility
            $facility = Facility::findOrFail($request->id);
            SecurityEquipment::create([
                'facility_id'=> $request->facility_id,
                'name' => $request->name,
                'facility_name' => $facility->name,
                'serial_number' => $request->serial_number,
                'description' => $request->description,
                'status' => $request->status,              
            ]);
            // Redirect to the facilities list with a success message
            return redirect()->route('security-equipments.index')->with('success', 'Security Equipment created successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(string $id)
    {
        //
        $securityEquipment = SecurityEquipment::with('facility')->findOrFail($id); 
        $maintainanceSchedules = $securityEquipment->maintenanceSchedules()->orderBy('created_at','DESC')->get();
        $statuses = SecurityEquipment::STATUSES;
        $facilities = Facility::all();
        return Inertia::render('SecurityEquipments/Edit',
            [
                'facilities'=>$facilities,
                'statuses' => $statuses,
                'securityEquipment'=> $securityEquipment,
                'maintainanceSchedules'=> $maintainanceSchedules
            ]
        );

    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
        $validator = Validator::make($request->all(),
            [
                'name' => 'required|string|max:255',
                'facility_id' => 'required|integer|exists:facilities,id',
                'description' => 'nullable|string|max:1000',
                'status' => 'required|string|max:255',           
            ]
        );
        // Check if validation passes
        if($validator->passes()){
            // Find the security equipment by ID
            $securityEquipment = SecurityEquipment::findOrFail($id);
            $facility = Facility::findOrFail($request->facility_id);
            // Update the security equipment details
            $securityEquipment->update([
                'facility_id'=> $request->facility_id,
                'name' => $request->name,
                'facility_name' => $facility->name, 
                'serial_number' => $request->serial_number,
                'description' => $request->description,
                'status' => $request->status,              
            ]);
            // Redirect to the facilities list with a success message
            return redirect()->route('security-equipments.index')->with('success', 'Security Equipment updated successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }

    }

    public function createSchedule(string $id){
        $securityEquipment = SecurityEquipment::findOrFail($id);
        return Inertia::render('SecurityEquipments/CreateSchedule',
            [
                'securityEquipment' => $securityEquipment,
            ]
        );
    }

    public  function storeSchedule(Request $request){
        $validator = Validator::make($request->all(),[
            'id' => 'required|integer',
            'last_performed_date' => 'nullable|date',
            'next_due_date' => 'nullable|date|after_or_equal:last_performed_date',
            'maintenance_type'=>'required|string',
            'status' => 'required|string',
            'frequency' => 'required|string',
            'assigned_to' => 'nullable|string',
            'description' => 'nullable|string',
        ]);
        if($validator->passes()){            
            $securityEquipment = SecurityEquipment::findOrFail($request->id);
            $securityEquipment->maintenanceSchedules()->create([                
                'maintenance_type' => $request->maintenance_type,
                'last_performed_date' => $request->last_performed_date,
                'next_due_date' => $request->next_due_date,
                'status' => $request->status,
                'frequency' => $request->frequency,
                'assigned_to' => $request->assigned_to,
                'description' => $request->description,
            ]);
            return redirect()->route('security-equipments.edit',$securityEquipment->id)->with('success', 'Maintenance schedule created successfully.');
        }else{
            return response()->json(['errors' => $validator->errors()], 422);
        }
        
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
        $securityEquipment = SecurityEquipment::findOrFail($id);
        // Delete the security equipment
        $securityEquipment->delete();       
        return response()->json(
            ['success' => 'Security Equipment deleted successfully.',
            'status' => true
            ], 
            200
        );         
    }

    public function deleteMaintenanceSchedule(string $id){
        $schedule = MaintenanceSchedule::findOrFail($id);
        if (!$schedule) {
            return response()->json(['error' => 'Maintenance schedule not found'], 404);
        }
        // Delete the security equipment
        $schedule->delete();
        return response()->json(
            ['success' => 'Maintenance schedule deleted successfully.',
            'status' => true
            ], 
            200
        );
    }
}
