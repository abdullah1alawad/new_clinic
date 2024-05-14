<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Chair extends Model
{
    use HasFactory;

    protected $fillable = [
        'clinic_id',
        'chair_number',
        'created_at', 'updated_at'
    ];

    protected $hidden = [
        'created_at', 'updated_at'
    ];

    protected $casts = [
        'clinic_id' => 'unsignedBigInteger',
        'chair_number' => 'unsignedBigInteger',
    ];

    public function clinic()
    {
        return $this->belongsTo(Clinic::class);
    }

    public function processes()
    {
        return $this->hasMany(Process::class);
    }
}
