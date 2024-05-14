<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Patient extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'gender',
        'national_id',
        'birth_date',
        'height', 'weight',
        'address', 'job',
        'phone',
        'questions',
        'last_medical_scan_date',
        'personal_doctor_name',
        'currently_disease', 'skin_disease', 'skin_surgery',
        'reason_to_go_hospital',
        'reason_to_transform_blood', 'skin_tooth_disease',
        'reason_to_came',
        'signature',
        'created_at', 'updated_at',
    ];


    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'created_at', 'updated_at',
    ];

    protected $casts = [
        'name' => 'string',
        'gender' => 'boolean',
        'national_id' => 'unsignedBigInteger',
        'birth_date' => 'date',
        'height' => 'float',
        'weight' => 'float',
        'address' => 'string',
        'job' => 'string',
        'phone' => 'string',
        'questions' => 'bigInteger',
        'last_medical_scan_date' => 'date',
        'personal_doctor_name' => 'string',
        'currently_disease' => 'string',
        'skin_disease' => 'string',
        'skin_surgery' => 'string',
        'reason_to_go_hospital' => 'string',
        'reason_to_transform_blood' => 'string',
        'skin_tooth_disease' => 'string',
        'reason_to_came' => 'string',
        'signature' => 'string',
    ];


    public function student()
    {
        return $this->belongsTo(User::class, 'student_id', 'id');
    }

    public function doctor()
    {
        return $this->belongsTo(User::class, 'doctor_id', 'id');
    }

    public function processes()
    {
        return $this->hasMany(Process::class);
    }

    public function diseases()
    {
        return $this->hasMany(Disease::class);
    }

    public function medicines()
    {
        return $this->hasMany(Medicine::class);
    }

    public function getGenderAttribute($val)
    {
        return (!$val) ? 'Male' : 'Female';
    }

    public function setGenderAttribute($val)
    {
        $this->attributes['gender'] = strtolower($val) == 'female' ? 1 : 0;
    }

    public function getQuestionsAttribute($val)
    {
        $ret = array();
        while ($val != 0) {
            if ($val & 1)
                $ret[] = 'YES';
            else
                $ret[] = 'NO';

            $val = (int)$val / 2;
        }

        return $ret;
    }

}
