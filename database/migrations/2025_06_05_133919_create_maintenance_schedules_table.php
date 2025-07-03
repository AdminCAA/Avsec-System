<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('maintenance_schedules', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('security_equipment_id');
            $table->foreign('security_equipment_id')->references('id')->on('security_equipment')->onDelete('cascade');                        
            $table->date('last_performed_date')->nullable(); // Date when the last maintenance was performed	
            $table->date('next_due_date'); // Date when the next maintenance is due
            $table->string('maintenance_type'); // e.g., 'inspection', 'repair', 'replacement'
            $table->string('status'); // e.g., 'scheduled', 'completed', 'overdue'
            $table->string('assigned_to')->nullable(); // Person or team responsible for the maintenance task
            $table->string('frequency'); // e.g., 'monthly', 'quarterly', 'yearly'
            $table->string('description')->nullable(); // Optional description of the maintenance task

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('maintenance_schedules');
    }
};
