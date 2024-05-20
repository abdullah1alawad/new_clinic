<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('patients', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('name');
            $table->string('national_id')->unique();
            $table->boolean('gender');
            $table->date('birth_date');
            $table->float('height');
            $table->float('weight');
            $table->string('address');
            $table->string('job');
            $table->string('phone')->unique();
            $table->string('questions');
            $table->date('last_medical_scan_date')->nullable();
            $table->string('personal_doctor_name')->nullable();
            $table->string('currently_disease')->nullable();
            $table->string('skin_disease')->nullable();
            $table->string('skin_surgery')->nullable();
            $table->string('reason_to_go_hospital')->nullable();
            $table->string('reason_to_transform_blood')->nullable();
            $table->string('skin_tooth_disease')->nullable();
            $table->string('reason_to_came')->nullable();
            $table->string('signature');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('patients');
    }
};
