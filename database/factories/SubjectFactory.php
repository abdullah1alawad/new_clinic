<?php

namespace Database\Factories;

use App\Models\Clinic;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Subject>
 */
class SubjectFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $doctor = User::whereHas('roles', function ($query) {
            $query->where('name', 'doctor');
        })->inRandomOrder()->first()->id;

        return [
            'name' => $this->faker->city,
            'doctor_id' => $doctor,
            'clinic_id' => Clinic::all()->random()->id,
        ];
    }
}
