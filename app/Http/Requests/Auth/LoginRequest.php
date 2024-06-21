<?php

namespace App\Http\Requests\Auth;

use App\traits\GeneralTrait;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Validation\ValidationException;

class LoginRequest extends FormRequest
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
            'username' => ['required', 'exists:users,username', 'max:20'],
            'password' => ['required', 'max:20']
        ];
    }

    /**
     * Get the error messages for the defined validation rules.
     *
     * @return array
     */

    public function messages()
    {
        return [
            'username.required' => 'حقل اسم المستخدم مطلوب.',
            'username.exists' => 'اسم المستخدم المقدم غير موجود في سجلاتنا.',
            'username.max' => 'لا يجوز أن يزيد اسم المستخدم عن 20 حرفًا.',
            'password.required' => 'حقل كلمة المرور مطلوب.',
            'password.max' => 'لا يجوز أن تزيد كلمة المرور عن 20 حرفًا.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = $this->apiResponse(null, false, $errors->all(), 422);

        throw new ValidationException($validator, $response);
    }
}
