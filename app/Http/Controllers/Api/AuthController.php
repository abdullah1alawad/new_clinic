<?php


//$upcomingAppointments = $user->studentProcesses()
//    ->where('date', '>=', $current_time)
//    ->where('status', 1)
//    ->with(['relatedModel1', 'relatedModel2']) // Adjust related models as needed
//    ->select(['id', 'date', 'status', 'related_column1', 'related_column2'])
//    ->get();

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Auth\LoginRequest;
use App\Http\Resources\StudentResource;
use App\Http\Resources\UserResource;
use App\traits\GeneralTrait;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    use GeneralTrait;

    public function login(LoginRequest $request)
    {
        try {
            $data = $request->validated();

            $user = User::where('username', $data['username'])->first();

            if (!Hash::check($data['password'], $user->password)) {
                return $this->apiResponse(null, false, 'wrong password', 401);
            }

            $user->tokens()->delete();
            $user->token = $user->createToken('clinic')->plainTextToken;

            return $this->apiResponse(['id' => $user->id, 'token' => $user->token], true, 'The user is logged in successfully.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function logout(Request $request)
    {
        auth('sanctum')->user()->tokens()->delete();

        return $this->apiResponse(null, true, 'Logged out successfully');
    }
}
