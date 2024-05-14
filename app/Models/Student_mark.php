<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Student_mark extends Model
{
    use  HasFactory;


    protected $fillable = [
        'student_id',
        'subject_id',
        'mark',
        'created_at','updated_at',
    ];


    protected $hidden = [
        'created_at','updated_at',
    ];

    protected $casts=[
        'student_id'=>'unsignedBigInteger',
        'subject_id'=>'unsignedBigInteger',
        'mark'=>'unsignedBigInteger',
    ];

    public function student(){
        return $this->belongsTo(User::class,'student_id','id');
    }

    public function subject(){
        return $this->belongsTo(Subject::class);
    }
}
