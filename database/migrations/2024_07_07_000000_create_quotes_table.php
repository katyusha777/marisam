<?php

// database/migrations/2024_07_07_000000_create_quotes_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class() extends Migration {
    public function up(): void {
        Schema::create('quotes', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->text('text');
            $table->string('author_name');
            $table->string('author_image')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void {
        Schema::dropIfExists('quotes');
    }
};
