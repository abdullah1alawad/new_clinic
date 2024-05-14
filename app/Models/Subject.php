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
        'created_at', 'updated_at',
    ];


    protected $hidden = [
        'created_at', 'updated_at',
    ];

    protected $casts = [
        'id'=>'unsignedBigInteger',
        'name'=>'string',
    ];

    public function studentMarks()
    {
        return $this->hasMany(Student_mark::class);
    }

    public function processes()
    {
        return $this->hasMany(Process::class);
    }
}
