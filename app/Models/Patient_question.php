<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Patient_question extends Model
{
    use HasFactory;

    protected $fillable = [
        'clinic_id',
        'question',
        'validation',
        'created_at', 'updated_at'
    ];

    protected $hidden = [
        'created_at', 'updated_at'
    ];

    protected $casts = [
        'clinic_id' => 'integer',
        'question' => 'string',
        'validation' => 'integer',
    ];

    public function clinic()
    {
        return $this->belongsTo(Clinic::class);
    }
}
