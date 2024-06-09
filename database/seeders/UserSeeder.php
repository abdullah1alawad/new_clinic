<?php

namespace Database\Seeders;

use App\Models\User;
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
//        User::factory(30)->create();
        DB::table('users')->insert([
            'username' => 'abdullah_alawad_',
            'email'=>'abdullah@gmail.com',
            'name'=>'abdullah alawad',
            'national_id' => '1234567',
            'gender' => 0,
            'phone' => '0957275976',
            'photo'=>'1716055673.jpg',
            'password' => Hash::make('12345678'),
        ]);
    }
}
