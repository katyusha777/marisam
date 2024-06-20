<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class() extends Migration {
    public function up() {
        Schema::create('pages', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('title');
            $table->string('header_image');
            $table->string('slug')->unique();
            $table->text('body');
            $table->uuid('parent_id')->nullable();
            $table->json('blocks')->nullable();
            $table->timestamps();
        });
    }

    public function down() {
        Schema::dropIfExists('pages');
    }
};
