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
        Schema::create('reference_documents', function (Blueprint $table) {
            $table->id();
            $table->foreignId('protocol_question_id')->constrained()->onDelete('cascade');
            $table->timestamps();
            $table->string('name',255);
            $table->integer('doc_page')->nullable();
            $table->string('file_name')->nullable();                      
            $table->string('uploaded_by')->nullable();            
            $table->string('attachment')->nullable();            
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('reference_documents');
    }
};
