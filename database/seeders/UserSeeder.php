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
            'username' => 'abood',
            'email'=>'abd@doctor.com',
            'name'=>'abood',
            'national_id' => '12567',
            'gender' => 0,
            'phone' => '0957335986',
            'photo'=>'1716055673.jpg',
            'password' => Hash::make('12345678'),
        ]);
    }
}
