<?php

namespace App\traits;

use Illuminate\Http\Response;
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

    function saveImage($photo, $folder)
    {
        $photoName = $photo;
        $fileName = time() . '.' . $photoName->getClientOriginalExtension();
        $photoName->move(public_path($folder), $fileName);

        return $fileName;
    }

}
