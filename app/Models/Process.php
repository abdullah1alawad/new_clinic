<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Process extends Model
{
    use HasFactory;

    protected $fillable = [
        'student_id',
        'doctor_id',
        'patient_id',
        'assistant_id',
        'chair_id',
        'subject_id',
        'date',
        'photo',
        'created_at', 'updated_at',
    ];


    protected $hidden = [
        'created_at', 'updated_at',
    ];


    protected $casts = [
        'student_id' => 'unsignedBigInteger',
        'doctor_id' => 'unsignedBigInteger',
        'patient_id' => 'unsignedBigInteger',
        'assistant_id' => 'unsignedBigInteger',
        'chair_id' => 'unsignedBigInteger',
        'subject_id' => 'unsignedBigInteger',
        'date' => 'date',
        'photo' => 'string',
        'status' => 'boolean',
        'mark' => 'unsignedBigInteger',
    ];

    public function student()
    {
        return $this->belongsTo(User::class, 'student_id', 'id');
    }

    public function doctor()
    {
        return $this->belongsTo(User::class, 'doctor_id', 'id');
    }

    public function assistant()
    {
        return $this->belongsTo(User::class, 'assistant_id', 'id');
    }

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }

    public function chair()
    {
        return $this->belongsTo(Chair::class);
    }

    public function subject()
    {
        return $this->belongsTo(Subject::class);
    }

    public function marks()
    {
        return $this->hasMany(Subprocess_mark::class);
    }
}
