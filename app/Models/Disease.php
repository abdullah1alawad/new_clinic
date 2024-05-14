<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Disease extends Model
{
    use HasFactory;

    protected $fillable=[
        'patient_id',
        'name',
        'created_at','updated_at'
    ];

    protected $hidden=[
        'created_at','updated_at'
    ];

    protected $casts=[
        'patient_id'=>'unsignedBigInteger',
        'name'=>'string',

    ];

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }
}
