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
            $table->string('cap_file')->nullable();
            $table->string('cap_status')->nullable();
            $table->string('reason_for_rejection')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('selected_checklist_questions', function (Blueprint $table) {
            //
            $table->dropColumn('cap_file');
            $table->dropColumn('cap_status');
            $table->dropColumn('reason_for_rejection');
        });
    }
};
