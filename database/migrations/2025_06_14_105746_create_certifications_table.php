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
        Schema::create('certifications', function (Blueprint $table) {
            $table->id();    
            // User relationship
            $table->foreignId('user_id')->constrained()->onDelete('cascade'); // Foreign key to users table    
            $table->string('certification_name'); // Name of the certification
            $table->string('certification_body'); // Body that issued the certification
            $table->date('date_issued')->nullable(); // Date when the certification was issued
            $table->date('expiry_date')->nullable(); // Expiry date of the certification
            $table->string('certification_number')->nullable(); // Unique number for the certification
            $table->string('status'); // Status of the certification (e.g., active, expired, revoked)
            $table->integer('score')->nullable(); // Score or grade obtained in the certification, if applicable
            $table->string('remarks')->nullable(); // Additional remarks or comments about the certification
            $table->string('certification_type'); // e.g., 'Certification', 'License', etc.
            $table->string('certification_file')->nullable(); // File path for the certification document, if applicable    
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('certifications');
    }
};
