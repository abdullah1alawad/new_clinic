<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class Patient_questionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('Patient_questions')->insert([
            'clinic_id' => '1',
            'question' => 'اسم اخر مشفى زرتها.',
            'validation' => 'string',
            'is_null' => 1,
        ]);
        DB::table('Patient_questions')->insert([
            'clinic_id' => '1',
            'question' => 'هل تحب المشفى.',
            'validation' => 'boolean',
            'is_null' => 0,
        ]);
        DB::table('Patient_questions')->insert([
            'clinic_id' => '1',
            'question' => 'متى اخر مرة.',
            'validation' => 'date',
            'is_null' => 0
        ]);
        DB::table('Patient_questions')->insert([
            'clinic_id' => '1',
            'question' => 'ادخل الملف.',
            'validation' => 'image',
            'is_null' => 0
        ]);
        DB::table('Patient_questions')->insert([
            'clinic_id' => '1',
            'question' => 'ادخل طولك.',
            'validation' => 'numeric',
            'is_null' => 0
        ]);
        DB::table('Patient_questions')->insert([
            'clinic_id' => '1',
            'question' => 'ادخل كل أمراضك.',
            'validation' => 'array',
            'is_null' => 0
        ]);

    }
}
