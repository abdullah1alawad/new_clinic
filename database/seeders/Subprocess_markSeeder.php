<?php

namespace Database\Seeders;

use App\Models\Subprocess_mark;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class Subprocess_markSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        Subprocess_mark::factory(10)->create();
    }
}
