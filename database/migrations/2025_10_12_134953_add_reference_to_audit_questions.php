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
        Schema::table('audit_questions', function (Blueprint $table) {
            //
            $table->string('reference',60)->nullable()->after('question');
            $table->string('reference_doc',100)->nullable()->after('reference');
            $table->text('reference_search_text')->nullable()->after('reference_doc');  
            $table->text('risk_description')->nullable()->after('reference_search_text');                         
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('audit_questions', function (Blueprint $table) {
            //
            $table->dropColumn('reference');
            $table->dropColumn('reference_doc');
            $table->dropColumn('reference_search_text');            
            $table->dropColumn('risk_description');
        });
    }
};
