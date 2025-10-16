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
        Schema::create('mandatory_courses', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')
                  ->constrained()
                  ->onDelete('cascade');
            $table->string('course_name');
            $table->string('training_center')->nullable();
            $table->string('certificate_number')->nullable();
            $table->date('date_issued')->nullable();
            $table->date('expiry_date')->nullable();
            $table->string('status')->default('Active');
            $table->string('attachment')->nullable(); // file upload
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('mandatory_courses');
    }
};
