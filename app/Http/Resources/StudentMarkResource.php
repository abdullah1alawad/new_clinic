<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Carbon;

class StudentMarkResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $user = auth('sanctum')->user();
        $current_time = Carbon::now();
        $subjectId = $this->subject_id;

        $upcomingAppointmentsForSubjects = $user->studentProcesses()
            ->where('subject_id', $subjectId)
            ->where('date', '>=', $current_time)
            ->where('status', '>', 0)
            ->get();

        $completedAppointmentsForSubjects = $user->studentProcesses()
            ->where('subject_id', $subjectId)
            ->where('date', '<', $current_time)
            ->where('status', '>', 0)
            ->get();

        return [
            'subject_name' => $this->subject->name,
            'mark' => $this->mark,
            'appointments' => [
                'upcomingAppointmentsForSubjects' => UpcomingAppointmentsResource::collection($upcomingAppointmentsForSubjects),
                'completedAppointmentsForSubjects' => CompletedAppointmentsResource::collection($completedAppointmentsForSubjects),
            ],
        ];
    }
}
