<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PatientResource extends JsonResource
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
            'name' => $this->name,
            'gender' => $this->gender,
            'national_id' => $this->national_id,
            'birth_date' => $this->birth_date,
            'height' => $this->height,
            'weight' => $this->weight,
            'address' => $this->address,
            'job' => $this->job,
            'phone' => $this->phone,
            'questions' => $this->questions,
            'last_medical_scan_date' => $this->last_medical_scan_date,
            'personal_doctor_name' => $this->personal_doctor_name,
            'currently_disease' => $this->currently_disease,
            'skin_disease' => $this->skin_disease,
            'skin_surgery' => $this->skin_surgery,
            'reason_to_go_hospital' => $this->reason_to_go_hospital,
            'reason_to_transform_blood' => $this->reason_to_transform_blood,
            'skin_tooth_disease' => $this->skin_tooth_disease,
            'reason_to_came' => $this->reason_to_came,
            'diseases' => DiseaseResource::collection($this->whenLoaded('diseases')),
            'medicines' => MedicineResource::collection($this->whenLoaded('medicines')),
        ];
    }
}
