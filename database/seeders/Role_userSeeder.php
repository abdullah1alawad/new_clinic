<?php

namespace Database\Seeders;

use App\Models\Userrole;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Role_userSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'2']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'2']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'2']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'2']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'2']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'3']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'3']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'3']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'3']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'3']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'4']);
        DB::table('role_user')->insert(['user_id'=>'1','role_id'=>'4']);
    }
}
