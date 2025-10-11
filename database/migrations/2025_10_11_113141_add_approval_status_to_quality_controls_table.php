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
        Schema::table('quality_controls', function (Blueprint $table) {
            //
            $table->string('approval_status',20)->default('Pending');
            $table->string('approved_by',50)->nullable();
            $table->timestamp('approved_at')->nullable()->after('approval_status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('quality_controls', function (Blueprint $table) {
            //
            $table->dropColumn('approval_status');
            $table->dropColumn('approved_by');
            $table->dropColumn('approved_at');
        });
    }
};
