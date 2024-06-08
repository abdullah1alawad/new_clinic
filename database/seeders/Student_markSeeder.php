<?php

namespace Database\Seeders;

use App\Models\Student_mark;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Student_markSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Student_mark::factory(40)->create();
    }
}
