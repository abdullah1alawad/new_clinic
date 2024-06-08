<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('roles')->insert(['name' => 'admin']);
        DB::table('roles')->insert(['name' => 'student']);
        DB::table('roles')->insert(['name' => 'doctor']);
        DB::table('roles')->insert(['name' => 'assistant']);
        DB::table('roles')->insert(['name' => 'banned']);
        DB::table('roles')->insert(['name' => 'pending']);
    }
}
