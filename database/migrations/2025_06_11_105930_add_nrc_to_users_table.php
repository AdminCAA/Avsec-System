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
        Schema::table('users', function (Blueprint $table) {
            //
            $table->string('nrc',12)->nullable()->after('email'); // Adjust position as needed
            $table->integer('facility_id')->nullable()->after('id'); // Adjust position as needed
            $table->string('user_type')->nullable()->after('facility_id'); // Adjust position as needed            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            //
            $table->dropColumn('nrc');
            $table->dropColumn('facility_id');
            $table->dropColumn('user_type');
        });

        
    }
};
