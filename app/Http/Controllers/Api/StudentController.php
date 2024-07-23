<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use App\traits\GeneralTrait;

class StudentController extends Controller
{

    use GeneralTrait;

    public function configuration()
    {
        try {
            $user = auth('sanctum')->user();

            $current_time = Carbon::now();

            $upcomingAppointments = $user->studentProcesses()
                ->where('date', '>=', $current_time)
                ->get();

            $completedAppointments = $user->studentProcesses()
                ->where('date', '<', $current_time)
                ->paginate(7);

            $notifications = $user->notifications()
                ->orderBy('created_at', 'desc')
                ->get();

            $studentMarks = $user->studentMarks()->paginate(7);

            $user = StudentResource::make($user, $upcomingAppointments, $completedAppointments, $studentMarks, $notifications);

            return $this->apiResponse($user, true, 'configuration data.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
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
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
