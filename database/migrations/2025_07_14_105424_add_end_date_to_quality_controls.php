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
        Schema::table('quality_controls', function (Blueprint $table) {
            //
            $table->date('end_date')->nullable()->after('scheduled_date'); // Adding end_date column after start_date            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('quality_controls', function (Blueprint $table) {
            //
            $table->dropColumn('end_date'); // Dropping end_date column if it exists
        });
    }
};
