<?php

namespace App\Http\Resources;

use App\Models\Patient_question;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Carbon;

class CompletedAppointmentsResource extends JsonResource
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

        $questions = [];
        if (is_array($this->questions)) { // temporary until data entry done
            foreach ($this->questions as $question) {
                $queryQuestion = Patient_question::find($question['id']);
                $questions[] = [
                    'id' => $queryQuestion->id,
                    'question' => $queryQuestion->question,
                    'answer' => $question['answer'],
                ];
            }
        }

        return [
            'id' => $this->id,
            'doctor_name' => $this->doctor->name,
            'assistant_name' => isset($this->assistant->name) ? $this->assistant->name : '',
            'subject_name' => $this->subject->name,
            'appointment_date' => $date_from_database->format('Y-m-d h:m A'),
            'time_difference' => $time_difference,
            'clinic_name' => $this->chair->clinic->name,
            'chair_number' => $this->chair->chair_number,
            'photo' => $this->photo,
            'status' => $this->status,
            'mark' => $this->mark,

            'patient_information' => $questions, //temporary
            'subprocesses' => SubProcess_markResource::collection($this->marks)
        ];
    }
}
