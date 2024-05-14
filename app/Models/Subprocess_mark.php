<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class Subprocess_mark extends Model
{
    use  HasFactory;


    protected $fillable = [
        'process_id',
        'name',
        'mark',
        'created_at',
        'updated_at',
    ];

    protected $hidden = [

        'created_at','updated_at',
    ];

    protected $casts=[
        'process_id'=>'unsignedBigInteger',
        'name'=>'string',
        'mark'=>'unsignedBigInteger',
    ];

    public function process(){
        return $this->belongsTo(Process::class);
    }
}
