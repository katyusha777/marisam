<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Laravel\Nova\Util;

class CreateActionEventsTable extends Migration {
    /**
     * Run the migrations.
     */
    public function up() {
        Schema::create('action_events', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->char('batch_id', 36);
            $table->foreignIdFor(Util::userModel(), 'user_id')->index();
            $table->string('name');

            $table->uuid('actionable_id')->nullable();
            $table->string('actionable_type')->nullable();

            $table->uuid('target_id')->nullable();
            $table->string('target_type')->nullable();

            $table->string('model_type');

            $table->uuid('model_id')->nullable();

            $table->text('fields');
            $table->string('status', 25)->default('running');
            $table->text('exception');
            $table->timestamps();

            $table->index(['batch_id', 'model_type', 'model_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down() {
        Schema::dropIfExists('action_events');
    }
}
