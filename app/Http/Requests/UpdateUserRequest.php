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
            'username.required' => 'حقل اسم المستخدم مطلوب.',
            'username.regex' => 'اسم المستخدم مثل الانستقرام',
            'name.required' => 'حقل الاسم مطلوب.',
            'name.regex' => 'يمكن أن يحتوي الاسم على أحرف فقط.',
            'name.max' => 'يجب أن يكون الاسم أقل من أو يساوي 40 حرفًا.',
            'national_id.required' => 'حقل الهوية الوطنية مطلوب.',
            'national_id.regex' => 'يمكن أن تحتوي الهوية الوطنية على أرقام فقط.',
            'national_id.max' => 'يجب أن يكون رقم الهوية الوطنية أقل من أو يساوي 30 رقمًا.',
            'gender.required' => 'الجنس مطلوب .',
            'phone.required' => 'حقل الهاتف مطلوب.',
            'phone.regex' => 'يمكن أن يحتوي الهاتف على أرقام فقط.',
            'phone.max' => 'يمكن أن يحتوي الهاتف على 10 أرقام فقط.',
            'photo.image' => 'يجب عليك اختيار صورة صالحة مثل png، jpg الخ ....',
            'photo.max' => 'اختر حجم صورة أقل من أو يساوي 2048 كيلو بايت.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = $this->apiResponse(null, false, $errors->all(), 422);

        throw new ValidationException($validator, $response);
    }
}

