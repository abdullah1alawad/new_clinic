<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('users')->insert([
            'username' => 'abdullah',
            'email' => 'abdullahalawad23@gmail.com',
            'name' => 'abdullah alawad',
            'gender' => '0',
            'phone' => '0957275976',
            'password' => Hash::make('abd12345'),
            'national_id' => '050200056',
        ]);
    }
}
