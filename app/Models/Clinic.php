<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Clinic extends Model
{
    use HasFactory;

    protected $fillable = [
        'id',
        'name',
        'created_at', 'updated_at',
    ];

    protected $hidden = [
        'created_at', 'updated_at',
    ];

    protected $casts = [
        'id' => 'integer',
        'name' => 'string',
    ];

    public function chairs()
    {
        return $this->hasMany(Chair::class);
    }

    public function question()
    {
        return $this->hasMany(Patient_question::class);
    }

    public function subjects()
    {
        return $this->hasMany(Subject::class);
    }
}
