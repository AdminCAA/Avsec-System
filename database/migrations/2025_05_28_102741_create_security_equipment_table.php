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
        Schema::create('security_equipment', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('facility_id');              
            $table->foreign('facility_id')
                ->references('id')
                ->on('facilities')
                ->onDelete('cascade');
            $table->string('name', 150);
            $table->string('serial_number', 150)->nullable();
            $table->string('facility_name', 150)->nullable();
            $table->text('description')->nullable();
            $table->string('status');   
            $table->softDeletes();                                  
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('security_equipment');
    }
};
