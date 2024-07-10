<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Carbon;

class UpcomingAppointmentsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {

        $current_time = Carbon::now();
        $date_from_database = Carbon::parse($this->date);
        $time_difference = $date_from_database->diffForHumans($current_time);


        return [
            'id' => $this->id,
            'doctor_name' => $this->doctor->name,
            'assistant_name' => isset($this->assistant->name) ? $this->assistant->name : '',
            'subject_name' => $this->subject->name,
            'appointment_date' => $date_from_database->format('Y-m-d H:m'),
            'time_difference' => $time_difference,
            'clinic_name' => $this->chair->clinic->name,
            'chair_number' => $this->chair->chair_number,
            'photo' => $this->photo,
            'status' => $this->status,
            'mark' => null,
            'patient_information' => $this->questions,
            'subprocesses' => SubProcess_markResource::collection($this->marks),
        ];
    }
}
