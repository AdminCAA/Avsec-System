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
        Schema::create('selected_checklist_questions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('quality_control_id')->constrained()->onDelete('cascade');
            $table->text('question');            
            $table->text('finding_observation')->nullable();
            $table->string('finding_category')->nullable();
            $table->text('action_taken')->nullable();
            $table->text('problem_cause')->nullable();
            $table->text('short_term_action')->nullable();
            $table->text('long_term_action')->nullable();
            $table->date('completion_date')->nullable();
            $table->date('follow_up_date')->nullable();
            $table->string('proposed_follow_up_action')->nullable();
            $table->date('date_of_closure')->nullable();
            $table->string('status')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('selected_checklist_questions');
    }
};
