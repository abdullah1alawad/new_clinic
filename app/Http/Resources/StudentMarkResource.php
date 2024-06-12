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

        $appointmentsForSubjects = $user->studentProcesses()
            ->where('subject_id', $subjectId)
            ->where('status', '>', 0)
            ->paginate(7);

        return [
            'subject_name' => $this->subject->name,
            'mark' => $this->mark,
            'appointments' => CompletedAppointmentsResource::collection($appointmentsForSubjects),
        ];
    }
}
