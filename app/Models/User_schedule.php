<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class User_schedule extends Model
{
    use  HasFactory;

    protected $fillable = [
        'user_id',
        'time_of_work',
        'created_at',
        'updated_at',
    ];

    protected $hidden = [

        'created_at', 'updated_at',
    ];

    protected $casts = [
        'id' => 'integer',
        'user_id' => 'integer',
        'time_of_work' => 'array',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
