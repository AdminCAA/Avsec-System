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
        Schema::table('qualifications', function (Blueprint $table) {
            //
            $table->string('qualification_file')->nullable(); // File path for the certification document, if applicable    
            $table->string('qualification_number')->nullable(); // Unique number for the certification            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('qualifications', function (Blueprint $table) {
            //
            $table->dropColumn('qualification_file');
            $table->dropColumn('qualification_number');
        });
    }
};
