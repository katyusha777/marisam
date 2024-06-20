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
            $table->uuid('site_id');
            $table->json('blocks')->nullable();
            $table->boolean('is_frontpage')->default(false);
            $table->boolean('is_cta_page')->default(false);
            $table->timestamps();

            $table->foreign('parent_id')->references('id')->on('pages')->onDelete('set null');
        });
    }

    public function down() {
        Schema::dropIfExists('pages');
    }
};
