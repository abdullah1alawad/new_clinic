<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use App\Notifications\MessageSent;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use  HasFactory, HasApiTokens, Notifiable;

    protected $table = "users";

    protected $fillable = [
        'email', 'name', 'gender',
        'username',
        'phone',
        'photo',
        'national_id',
        'password',
        'created_at', 'updated_at',
    ];


    protected $hidden = [
        'password',
        'remember_token',
        'created_at', 'updated_at',
    ];


    protected $costs = [
        'id' => 'integer',
        'email' => 'string',
        'name' => 'string',
        'gender' => 'boolean',
        'phone' => 'string',
        'photo' => 'string',
        'national_id' => 'integer',
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
    ];


    public function studentPatients()
    {
        return $this->hasMany(Patient::class, 'student_id', 'id');
    }

    public function doctorPatients()
    {
        return $this->hasMany(Patient::class, 'doctor_id', 'id');
    }

    public function roles()
    {
        return $this->belongsToMany(Role::class);
    }

    public function studentProcesses()
    {
        return $this->hasMany(Process::class, 'student_id', 'id');
    }

    public function doctorProcesses()
    {
        return $this->hasMany(Process::class, 'doctor_id', 'id');
    }

    public function assistantProcesses()
    {
        return $this->hasMany(Process::class, 'assistant_id', 'id');
    }

    public function studentMarks()
    {
        return $this->hasMany(Student_mark::class, 'student_id', 'id');
    }

    public function schedules()
    {
        return $this->hasMany(User_schedule::class);
    }

    public function subjects()
    {
        return $this->hasMany(Subject::class, 'doctor_id', 'id');
    }

    public function chats()
    {
        return $this->hasMany(Chat::class, 'created_by');
    }

    public function routeNotificationForOneSignal()
    {
        return ['tags' => ['key' => 'userId', 'relation' => '=', 'value' => (string)($this->id)]];
    }

    public function sendNewMessageNotification(array $data): void
    {
        $this->notify(new MessageSent($data));
    }

    public function getGenderAttribute($val)
    {
        return (!$val) ? 'Male' : 'Female';
    }

    public function isAssistant(): bool
    {
        return $this->roles()->where('name', 'assistant')->exists();
    }

//    public function setGenderAttribute($val){
//        $this->attributes['gender']=strtolower($val)=='female'? 1 : 0;
//        dd($this->attributes['gender']);
//    }
}
