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
        Schema::table('selected_checklist_questions', function (Blueprint $table) {
            //
            $table->string('audit_area_name')->nullable()->after('id'); // Adjust position as needed
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('selected_checklist_questions', function (Blueprint $table) {
            //
            $table->dropColumn('audit_area_name');
        });
    }
};
