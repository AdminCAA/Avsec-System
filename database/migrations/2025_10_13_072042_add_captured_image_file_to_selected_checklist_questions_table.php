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
            $table->json('captured_image_file')->nullable()->after('evidence_file');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('selected_checklist_questions', function (Blueprint $table) {
            $table->dropColumn('captured_image_file');
        });
    }
};
