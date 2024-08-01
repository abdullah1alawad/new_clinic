<?php

namespace App\Http\Controllers;

use App\Http\Requests\ResetUserPasswordRequest;
use App\Http\Requests\UpdateUserRequest;
use App\Http\Resources\UserResource;
use App\Models\User;
use App\traits\GeneralTrait;
use Illuminate\Http\Request;
use Illuminate\Notifications\Notification;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    use GeneralTrait;

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        // get the rules you need
        $users = User::where('id', '!=', auth('sanctum')->user()->id)->get();
        return $this->apiResponse($users, true, 'all required users');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(UpdateUserRequest $request)
    {
        try {
            $user = auth('sanctum')->user();

            if ($request->hasFile('photo')) {
                /// TODO delete the old image
                $photoPath = $this->saveImage($request->file('photo'), 'images');
                $user->photo = $photoPath;
            }

            $user->username = $request->username;
            $user->name = $request->name;
            $user->email = $request->email;
            $user->national_id = $request->national_id;
            $user->gender = $request->gender;
            $user->phone = $request->phone;

            $user->save();

            $user = UserResource::make($user);
            return $this->apiResponse($user, true, 'the user has been updated successfully.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }

    }

    public function resetPassword(ResetUserPasswordRequest $request)
    {
        $user = auth('sanctum')->user();

        try {
            $user->password = Hash::make($request->input('newPassword'));
            $user->save();

            return $this->apiResponse(null, true, 'the password has been updated successfully.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }


    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }


    public function makeNotificationRead(Request $request)
    {
        $rules = [
            'notification_id' => 'required|exists:notifications,id',
        ];

        $messages = [
            'notification_id.required' => 'The notification_id is required.',
            'notification_id.exists' => 'This notification does not exists.',
        ];

        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails())
            return $this->apiResponse(null, false, $validator->errors()->first(), 422);

        $userId = auth('sanctum')->user()->id;

        $affected = DB::table('notifications')
            ->where('id', $request->notification_id)
            ->where('notifiable_id', $userId)
            ->update(['read_at' => now()]);

      
        return $this->apiResponse(null, true, 'Notification marked as read.');

    }
}
