<?php

namespace Database\Seeders;

use App\Models\User_schedule;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class User_scheduleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        User_schedule::factory(1)->create();
    }
}
