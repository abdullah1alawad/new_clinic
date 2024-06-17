<?php

namespace Database\Factories;

use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Model>
 */
class User_scheduleFactory extends Factory
{
    protected static $selectedDoctorIds = [];

    public function definition(): array
    {
        $doctor = $this->getUniqueDoctorId();

        $arr = [];
        for ($i = 1; $i <= $this->faker->numberBetween(1, 5); $i++) {
            $hour1 = $this->faker->numberBetween(8, 15);
            $minute1 = $this->faker->numberBetween(0, 59);

            $hour2 = $this->faker->numberBetween(8, 15);
            $minute2 = $this->faker->numberBetween(0, 59);

            $timeMin = sprintf('%02d:%02d', min($hour1, $hour2), min($minute1, $minute2));
            $timeMax = sprintf('%02d:%02d', max($hour1, $hour2), max($minute1, $minute2));

            $arr[$i] = [$timeMin, $timeMax];
        }

        return [
            'user_id' => $doctor,
            'time_of_work' => $arr
        ];
    }
    protected function getUniqueDoctorId()
    {
        $doctor = User::whereHas('roles', function ($query) {
            $query->where('name', 'doctor');
        })->whereNotIn('id', static::$selectedDoctorIds) // Ensure the doctor is not already selected
        ->inRandomOrder()
            ->first();

        if ($doctor) {
            // Add the selected doctor ID to the static array
            static::$selectedDoctorIds[] = $doctor->id;
            return $doctor->id;
        } else {
            // Handle case where no more unique doctors are available
            throw new \Exception('No more unique doctors available');
        }
    }
}
