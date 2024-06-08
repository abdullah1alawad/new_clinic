<?php

namespace Database\Factories;

use App\Models\Chair;
use App\Models\Patient;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Process>
 */
class ProcessFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $student = User::whereHas('roles', function ($query) {
            $query->where('name', 'student');
        })->inRandomOrder()->first()->id;

        $doctor = User::whereHas('roles', function ($query) {
            $query->where('name', 'doctor');
        })->inRandomOrder()->first()->id;

        $assistant = User::whereHas('roles', function ($query) {
            $query->where('name', 'assistant');
        })->inRandomOrder()->first()->id;

        return [
            'student_id' => $student,
            'doctor_id' => $doctor,
            'assistant_id' => $assistant,
            'patient_id' => Patient::all()->random()->id,
            'chair_id' => Chair::all()->random()->id,
            'subject_id' => Subject::all()->random()->id,
            'date' => $this->faker->dateTime,
            'photo' => $this->faker->url,
            'status' => $this->faker->numberBetween(1,5),
            'mark' => $this->faker->numberBetween(0,10),
        ];
    }
}
