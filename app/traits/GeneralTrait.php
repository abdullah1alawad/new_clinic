<?php

namespace App\traits;

use App\Events\NotificationSent;
use DateTime;
use Illuminate\Http\Response;
use Illuminate\Support\Carbon;
use Illuminate\Support\Collection;
use Psy\Util\Str;

trait GeneralTrait
{
    public function apiResponse($data = null, $status = true, $message = null, $statusCode = 200)
    {
        $array = [
            'data' => $data,
            'status' => $status,
            'message' => $message,
        ];
        return response()->json($array, $statusCode);
    }


//    public function apiResponse($data = null, $status = true, $message = null, $statusCode = 200)
//    {
//        $startTime = microtime(true);
//
//        $simpleData = $data->map(function($user) {
//            return [
//                'id' => $user->id,
//                'email' => $user->email,
//                'username' => $user->username,
//                'name' => $user->name,
//                'gender' => $user->gender,
//                'phone' => $user->phone,
//                'photo' => $user->photo,
//                'national_id' => $user->national_id
//            ];
//        });
//
//        $array = [
//            'data' => $simpleData,
//            'status' => $status,
//            'message' => $message,
//        ];
//
//        $response = response()->json($array, $statusCode);
//
//        $endTime = microtime(true);
//        $duration = $endTime - $startTime;
//
//        \Log::info("apiResponse duration: {$duration} seconds");
//
//        return $response;
//    }


    public function unAuthorisedResponse()
    {
        return $this->apiResponse(null, false, 'Unauthorised !!', 401);
    }

    public function notFoundMessage($more = null)
    {
        return $this->apiResponse(null, true, $more . ' Not found in our database !', 404);
    }

    public function requiredField($message)
    {
        return $this->apiResponse(null, false, $message, 200);
    }

    public function internalServer($message)
    {
        return $this->apiResponse(null, false, $message, 500);
    }

    public function apiValidation($request, $array): array
    {
        foreach ($array as $field) {
            if (!$request->has($field))
                return [false, 'Field ' . $field . ' is required'];
            if ($request[$field] == null)
                return [false, "Field " . $field . " can't be empty"];
        }
        return [true, 'No error'];
    }

    public function saveImage($photo, $folder)
    {
        $photoName = $photo;
        $fileName = time() . '.' . $photoName->getClientOriginalExtension();
        $photoName->move(public_path($folder), $fileName);

        return $fileName;
    }

    public function getDayByNumber($day)
    {
        switch ($day) {
            case 1:
                return 'Saturday';
            case 2:
                return 'Sunday';
            case 3:
                return 'Monday';
            case 4:
                return 'Tuesday';
            case 5:
                return 'Wednesday';
            case 6:
                return 'Thursday';
            default:
                return 'Invalid day number';
        }
    }

    public function getDayByDate($date)
    {
        // Create a Carbon instance from the given date
        $carbonDate = Carbon::parse($date);

        // Get the day of the week
        $dayOfWeek = $carbonDate->format('l'); // 'l' will return the full textual representation of the day

        return $dayOfWeek;
    }

    public function is_date($value)
    {
        if (!$value) return false;
        try {
            new DateTime($value);
            return true;
        } catch (\Exception $e) {
            return false;
        }
    }

    public function sendNotificationUser($user_id, $storedNotification)
    {
        broadcast(new NotificationSent($user_id, $storedNotification))->toOthers();
    }


}
