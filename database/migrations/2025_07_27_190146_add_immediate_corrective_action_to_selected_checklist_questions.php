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
            $table->text('immediate_corrective_action')->nullable();
            $table->text('recommendations')->nullable()->after('immediate_corrective_action');
            $table->string('reference')->nullable()->after('recommendations');
            $table->date('short_term_date')->nullable();
            $table->date('long_term_date')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('selected_checklist_questions', function (Blueprint $table) {
            //
            $table->dropColumn('immediate_corrective_action');
            $table->dropColumn('recommendations');
            $table->dropColumn('reference');
            $table->dropColumn('short_term_date');
            $table->dropColumn('long_term_date');            
        });
    }
};
