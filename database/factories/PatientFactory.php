<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Patient>
 */
class PatientFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'user_id' => User::all()->random()->id,
            'name' => $this->faker->name,
            'national_id' => $this->faker->unique()->randomNumber(5),
            'gender' => $this->faker->boolean,
            'birth_date' => $this->faker->date,
            'height' => $this->faker->randomFloat(3,60,220),
            'weight' => $this->faker->randomFloat(3,20,500),
            'address' => $this->faker->address,
            'job' => $this->faker->jobTitle,
            'phone' => $this->faker->unique()->phoneNumber,
            'questions' => $this->faker->randomElement([
                '110100011011011010001001110',
                '110100011111010010101101110',
                '110000111011011000001000110'
            ]),
            'last_medical_scan_date' => $this->faker->date,
            'personal_doctor_name' => $this->faker->name,
            'currently_disease' => $this->faker->colorName,
            'skin_disease' => $this->faker->colorName,
            'skin_surgery' => $this->faker->linuxProcessor,
            'reason_to_go_hospital' => $this->faker->realText,
            'reason_to_transform_blood' => $this->faker->bloodType(),
            'skin_tooth_disease' => $this->faker->firefox,
            'reason_to_came' => $this->faker->realText,
            'signature' => $this->faker->chrome,
        ];
    }
}
