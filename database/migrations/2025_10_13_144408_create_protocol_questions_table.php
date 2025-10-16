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
        Schema::create('protocol_questions', function (Blueprint $table) {
            $table->id(); 
            $table->foreignId('critical_element_type_id')->nullable();
            $table->timestamps();
            $table->text('question');
            $table->text('pq_number')->nullable();
            $table->text('answer')->default('Not Satisfactory');
            $table->string('status')->default('Open');
            $table->text('answer_details')->nullable();
            $table->string('pq_category')->nullable();
            $table->string('ce_category')->nullable();                              
            $table->string('assistance_status')->nullable();
            $table->string('icao_reference')->nullable();
            $table->string('responsible_entity')->nullable();
            $table->date('estimated_completion_date')->nullable();
            $table->string('gap_identified')->nullable();
            $table->date('actual_completion_date')->nullable();            
            $table->text('remarks')->nullable();                        
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('protocol_questions');
    }
};
