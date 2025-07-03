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
        Schema::create('quality_control_alerts', function (Blueprint $table) {
            $table->id();                       
            $table->foreignId('quality_control_id')->constrained()->onDelete('cascade'); // Foreign key to users table                        
            $table->integer('source_alert_id')->nullable(); // ID of the source alert, if applicable (e.g., from an external system)
            $table->string('source_alert_name')->nullable(); // Name of the source alert, if applicable
            $table->string('alert_type'); // Type of alert (e.g., 'Security', 'Safety', etc.)
            $table->string('alert_description'); // Description of the alert
            $table->string('alert_status'); 
            $table->date('alert_date')->nullable(); // Date when the alert was raised
            $table->date('alert_resolved_date')->nullable(); // Date when the alert was resolved, if applicable
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quality_control_alerts');
    }
};
