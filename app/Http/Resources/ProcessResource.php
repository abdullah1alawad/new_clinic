<?php

namespace App\Http\Resources;

use App\Models\Patient_question;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProcessResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
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
            'student_id' => $this->student->name,
            'doctor_id' => $this->doctor->name,
            'assistant' => isset($this->assistant->name) ? $this->assistant->name : '',
            'chair_number' => $this->chair->chair_number,
            'subject' => $this->subject->name,
            'questions' => $questions,
            'date' => $this->date,
            'photo' => $this->photo,
            'status' => $this->status,
            'mark' => isset($this->mark) ? $this->mark : '',
        ];
    }
}
