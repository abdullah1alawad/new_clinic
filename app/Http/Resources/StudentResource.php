<?php

namespace App\Http\Resources;

use Illuminate\Support\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StudentResource extends JsonResource
{

    private $upcomingAppointments, $completedAppointments, $studentMarks, $notifications;

    public function __construct($resource, $upcomingAppointments, $completedAppointments, $notifications, $studentMarks = null)
    {
        parent::__construct($resource);
        $this->upcomingAppointments = $upcomingAppointments;
        $this->completedAppointments = $completedAppointments;
        $this->studentMarks = $studentMarks;
        $this->notifications = $notifications;
    }

    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
//            'token' => $this->token,
//            'role' => RoleResource::collection($this->roles), // check it
            'profile' => [
                'id' => $this->id,
                'email' => $this->email,
                'username' => $this->username,
                'name' => $this->name,
                'gender' => $this->gender,
                'phone' => $this->phone,
                'photo' => $this->photo,
                'national_id' => $this->national_id,
            ],
            'appointments' => [
                'UpcomingAppointments' => UpcomingAppointmentsResource::collection($this->upcomingAppointments),
                'CompletedAppointments' => CompletedAppointmentsResource::collection($this->completedAppointments),
            ],
            'marks' => isset($this->studentMarks) ? StudentMarkResource::collection($this->studentMarks) : '',
            'notification' => NotificationResource::collection($this->notifications),
//            'notification' => $this->notifications,

        ];
    }
}
