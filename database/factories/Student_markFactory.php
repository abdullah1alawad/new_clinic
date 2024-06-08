<?php

namespace Database\Factories;

use App\Models\Subject;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Student_mark>
 */
class Student_markFactory extends Factory
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

        return [
            'student_id' => $student,
            'subject_id' => Subject::all()->random()->id,
            'mark' => $this->faker->numberBetween(1, 100),
        ];
    }
}
