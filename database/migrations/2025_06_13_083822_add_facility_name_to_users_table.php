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
            $table->string('gender', 10)->nullable()->after('email'); // Adjust position as needed
            $table->string('facility_name')->nullable()->after('is_certified'); // Adjust position as needed            
            $table->string('portrait')->nullable()->after('facility_name'); // Adjust position as needed
            $table->string('signature')->nullable()->after('portrait'); // Adjust position as needed
            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            //
            $table->dropColumn('gender');
            $table->dropColumn('facility_name');   
            $table->dropColumn('portrait');
            $table->dropColumn('signature');                     
        });
    }
};
