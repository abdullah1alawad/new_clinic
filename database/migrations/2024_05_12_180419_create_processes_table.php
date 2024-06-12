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
        Schema::create('processes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('student_id');
            $table->unsignedBigInteger('doctor_id');
            $table->unsignedBigInteger('assistant_id')->nullable();
            $table->unsignedBigInteger('chair_id');
            $table->unsignedBigInteger('subject_id');
            $table->longText('questions');
            $table->dateTime('date');
            $table->string('photo')->nullable();
            $table->boolean('status');
            $table->unsignedBigInteger('mark')->nullable();
            $table->timestamps();
            $table->foreign('student_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('doctor_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('assistant_id')->references('id')->on('users')->onDelete('cascade');
            $table->foreign('chair_id')->references('id')->on('chairs')->onDelete('cascade');
            $table->foreign('subject_id')->references('id')->on('subjects')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('processes');
    }
};
