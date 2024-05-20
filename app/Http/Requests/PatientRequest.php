<?php

namespace App\Http\Requests;

use Carbon\Carbon;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\ValidationException;
use App\traits\GeneralTrait;

class PatientRequest extends FormRequest
{
    use GeneralTrait;
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'name' => ['required', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'national_id' => ['required', 'regex:/^[0-9]+$/', 'max:30', 'unique:patients'],
            'birth_date' => ['required', 'date', 'before_or_equal:today', 'after_or_equal:' . Carbon::now()->subYears(100)->format('Y-m-d'),],
            'height' => [
                'required',
                'numeric',
                'min:1',
                'max:300',
            ],
            'weight' => [
                'required',
                'numeric',
                'min:1',
                'max:1000',
            ],
            'questions'=>[
                'required',
                'string',
                'size:50',
            ],
            'address' => [
                'required',
                'string',
                'min:1',
                'max:255',
                'regex:/^[0-9A-Za-z\s]+$/',
            ],
            'phone' => ['required', 'regex:/^[0-9]+$/', 'max:10', 'unique:patients'],
            'job' => [
                'required',
                'string',
                'min:1',
                'max:255',
            ],
            'last_medical_scan_date' => ['nullable', 'date', 'before_or_equal:today', 'after_or_equal:' . Carbon::now()->subYears(100)->format('Y-m-d'),],
            'personal_doctor_name' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'currently_disease' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'skin_disease' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'skin_surgery' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'reason_to_go_hospital' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'other_diseases' => ['nullable', 'array'],
            'other_diseases.*' => ['regex:/^[A-Za-z\s]+$/'],
            'reason_to_transform_blood' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'other_medicines' => ['nullable', 'array'],
            'other_medicines.*' => ['regex:/^[A-Za-z\s]+$/'],
            'skin_tooth_disease' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'reason_to_came' => ['nullable', 'regex:/^[A-Za-z\s]+$/', 'max:50'],
            'signature' => ['required', 'image', 'max:2048'],
        ];
    }

    public function messages()
    {
        return [
            'name.required' => 'The name field is required.',
            'name.regex' => 'The name field format is invalid.',
            'name.max' => 'The name field may not be greater than :max characters.',
            'national_id.required' => 'The national ID field is required.',
            'national_id.regex' => 'The national ID field format is invalid.',
            'national_id.max' => 'The national ID field may not be greater than :max characters.',
            'national_id.unique' => 'The national ID field has already been taken.',
            'birth_date.required' => 'The birth date field is required.',
            'birth_date.date' => 'The birth date field format is invalid.',
            'birth_date.before_or_equal' => 'The birth date field must be a date before or equal to today.',
            'birth_date.after_or_equal' => 'The birth date field must be a date after or equal to :date.',
            'height.required' => 'The height field is required.',
            'height.numeric' => 'The height field must be a number.',
            'height.min' => 'The height field must be at least :min.',
            'height.max' => 'The height field may not be greater than :max.',
            'weight.required' => 'The weight field is required.',
            'weight.numeric' => 'The weight field must be a number.',
            'weight.min' => 'The weight field must be at least :min.',
            'weight.max' => 'The weight field may not be greater than :max.',
            'address.required' => 'The address field is required.',
            'address.string' => 'The address field must be a string.',
            'address.min' => 'The address field must be at least :min characters.',
            'address.max' => 'The address field may not be greater than :max characters.',
            'address.regex' => 'The address field format is invalid.',
            'phone.required' => 'The phone field is required.',
            'phone.regex' => 'The phone field format is invalid.',
            'phone.max' => 'The phone field may not be greater than :max characters.',
            'phone.unique' => 'The phone field has already been taken.',
            'job.required' => 'The job field is required.',
            'job.string' => 'The job field must be a string.',
            'job.min' => 'The job field must be at least :min characters.',
            'job.max' => 'The job field may not be greater than :max characters.',
            'last_medical_scan_date.date' => 'The last medical scan date field format is invalid.',
            'last_medical_scan_date.before_or_equal' => 'The last medical scan date field must be a date before or equal to today.',
            'last_medical_scan_date.after_or_equal' => 'The last medical scan date field must be a date after or equal to :date.',
            'personal_doctor_name.regex' => 'The personal doctor name field format is invalid.',
            'personal_doctor_name.max' => 'The personal doctor name field may not be greater than :max characters.',
            'currently_disease.regex' => 'The currently disease field format is invalid.',
            'currently_disease.max' => 'The currently disease field may not be greater than :max characters.',
            'skin_disease.regex' => 'The skin disease field format is invalid.',
            'skin_disease.max' => 'The skin disease field may not be greater than :max characters.',
            'skin_surgery.regex' => 'The skin surgery field format is invalid.',
            'skin_surgery.max' => 'The skin surgery field may not be greater than :max characters.',
            'reason_to_go_hospital.regex' => 'The reason to go hospital field format is invalid.',
            'reason_to_go_hospital.max' => 'The reason to go hospital field may not be greater than :max characters.',
            'other_diseases.array' => 'The other diseases field must be an array.',
            'other_diseases.each' => 'The other diseases field format is invalid.',
            'reason_to_transform_blood.regex' => 'The reason to transform blood field format is invalid.',
            'reason_to_transform_blood.max' => 'The reason to transform blood field may not be greater than :max characters.',
            'other_medicines.array' => 'The other medicines field must be an array.',
            'other_medicines.each' => 'The other medicines field format is invalid.',
            'skin_tooth_disease.regex' => 'The skin tooth disease field format is invalid.',
            'skin_tooth_disease.max' => 'The skin tooth disease field may not be greater than :max characters.',
            'reason_to_came.regex' => 'The reason to came field format is invalid.',
            'reason_to_came.max' => 'The reason to came field may not be greater than :max characters.',
            'signature.required' => 'The signature field is required.',
            'signature.image' => 'The signature field must be an image.',
            'signature.max' => 'The signature field may not be greater than :max kilobytes.'
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = $this->apiResponse(null, false, $errors->all(), 422);

        throw new ValidationException($validator, $response);
    }
}
