<?php

namespace App\Http\Controllers;

use App\Http\Requests\ResetUserPasswordRequest;
use App\Http\Requests\UpdateUserRequest;
use App\Http\Resources\UserResource;
use App\Models\User;
use App\traits\GeneralTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

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

            $photoBath = $this->saveImage($request->file('photo'), 'images');

            $user->username = $request->username;
            $user->name = $request->name;
            $user->email = $request->email;
            $user->national_id = $request->national_id;
            $user->gender = $request->gender;
            $user->phone = $request->phone;
            $user->photo = $photoBath;

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
}
