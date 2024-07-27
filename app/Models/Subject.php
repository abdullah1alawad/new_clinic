<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Subject extends Model
{
    use  HasFactory;


    protected $fillable = [
        'id',
        'name',
        'clinic_id',
        'created_at', 'updated_at',
    ];


    protected $hidden = [
        'created_at', 'updated_at',
    ];

    protected $casts = [
        'id' => 'integer',
        'name' => 'string',
        'clinic_id' => 'integer',
    ];

    public function doctor()
    {
        return $this->belongsTo(User::class, 'doctor_id', 'id');
    }

    public function clinic()
    {
        return $this->belongsTo(Clinic::class);
    }

    public function studentMarks()
    {
        return $this->hasMany(Student_mark::class);
    }

    public function processes()
    {
        return $this->hasMany(Process::class);
    }
}
