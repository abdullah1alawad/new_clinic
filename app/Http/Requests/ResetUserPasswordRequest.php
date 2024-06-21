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
            'newPassword.required' => 'حقل كلمة المرور الجديدة مطلوب',
            'newPassword.regex' => 'يجب أن تحتوي كلمة المرور الجديدة على حروف وأرقام ويجب أن تحتوي على حرف واحد ورقم واحد على الأقل.',
            'newPassword.min' => 'يجب أن تحتوي كلمة المرور الجديدة على 8 أحرف على الأقل.',
            'newPassword.max' => 'يمكن أن تحتوي كلمة المرور الجديدة على 20 حرفًا فقط.',
            'newPassword.different' => 'يجب أن تكون كلمة المرور الجديدة مختلفة عن كلمة المرور القديمة.',
            'confirmPassword.same' => 'تأكيد كلمة المرور غير متطابق.',
        ];
    }

    protected function failedValidation(Validator $validator)
    {
        $errors = $validator->errors();

        $response = $this->apiResponse(null, false, $errors->all(), 422);

        throw new ValidationException($validator, $response);
    }
}
