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
        Schema::create('qualifications', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')
                  ->constrained()
                  ->onDelete('cascade'); // Foreign key to users table    
            $table->string('qualification_type'); // 'Degree', 'Certification', etc.
            $table->string('qualification_name');  // Name of the qualification
            $table->string('institution')->nullable(); // Institution name (optional)
            $table->date('date_obtained')->nullable(); // Date when qualification was obtained
    
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('qualifications');
    }
};
