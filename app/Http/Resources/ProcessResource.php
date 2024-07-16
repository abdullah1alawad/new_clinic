<?php

namespace App\Http\Resources;

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
        return [
            'id' => $this->id,
            'student_id' => $this->student->name,
            'doctor_id' => $this->doctor->name,
            'assistant' => isset($this->assistant->name) ? $this->assistant->name : '',
            'chair_number' => $this->chair->chair_number,
            'subject' => $this->subject->name,
            'questions'=>$this->questions,
            'date' => $this->date,
            'photo' => $this->photo,
            'status' => $this->status,
            'mark' => isset($this->mark) ? $this->mark : '',
        ];
    }
}
