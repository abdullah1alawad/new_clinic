<?php

namespace App\Http\Requests;

use App\traits\GeneralTrait;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class ResetUserPasswordRequest extends FormRequest
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
            'oldPassword' => ['required', function ($attribute, $value, $fail) {
                if (!Hash::check($value, auth('sanctum')->user()->password)) {
                    $fail('The old password is incorrect.');
                }
            },
            ],
            'newPassword' => ['required', 'regex:/^(?=.*[a-zA-Z])(?=.*\d).+$/', 'min:8', 'max:20', 'different:oldPassword'],
            'confirmPassword' => ['same:newPassword'],
        ];
    }

    public function messages()
    {
        return [
            'newPassword.required' => 'The new password field is required',
            'newPassword.regex' => 'The new password must have a letters and numbers and must contain at least one letter and one number.',
            'newPassword.min' => 'The new password should contain at least 8 characters.',
            'newPassword.max' => 'The new password can only have 20 characters.',
            'newPassword.different' => 'The new password must be different from the old password.',
            'confirmPassword.same' => 'The password confirmation does not match.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = $this->apiResponse(null, false, $errors->all(), 422);

        throw new ValidationException($validator, $response);
    }
}
