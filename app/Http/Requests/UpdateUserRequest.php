<?php

namespace App\Http\Requests;

use App\traits\GeneralTrait;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class UpdateUserRequest extends FormRequest
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
            'username' => ['required', 'regex:/^[a-zA-Z][a-zA-Z0-9._]{0,29}$/', Rule::unique('users')->ignore(auth('sanctum')->user()->id),],
            'name' => ['required', 'regex:/^[A-Za-z\s]+$/', 'max:40'],
            'email' => ['required', 'email', Rule::unique('users')->ignore(auth('sanctum')->user()->id)],
            'national_id' => ['required', 'regex:/^[0-9]+$/', 'max:30', Rule::unique('users')->ignore(auth('sanctum')->user()->id)],
            'gender' => ['required','boolean'],
            'phone' => ['required', 'regex:/^[0-9]+$/', 'max:10', Rule::unique('users')->ignore(auth('sanctum')->user()->id)],
            'photo' => ['image', 'max:2048'],
        ];
    }

    public function messages()
    {
        return [
            'username.required' => 'The username field is required.',
            'username.regex' => 'The username like instagram.',
            'name.required' => 'The name field is required.',
            'name.regex' => 'The name can have only letters.',
            'name.max' => 'The name must be less than or equal to 40 characters.',
            'national_id.required' => 'The national id field is required.',
            'national_id.regex' => 'The national id can only have numbers.',
            'national_id.max' => 'The national id must be less than or equal to 30 digits.',
            'gender.required' => 'The gender is required.',
            'phone.required' => 'The phone field is required.',
            'phone.regex' => 'The phone can only have a digits.',
            'phone.max' => 'The phone can only have 10 digits .',
            'photo.image' => 'you must choose a valid image like png , jpg etc ....',
            'photo.max' => 'choose an image size less than or equal to 2048KB.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = $this->apiResponse(null, false, $errors->all(), 422);

        throw new ValidationException($validator, $response);
    }
}

