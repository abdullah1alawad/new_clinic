<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use Illuminate\Http\Request;
use App\traits\GeneralTrait;
use Illuminate\Support\Carbon;

class DoctorController extends Controller
{
    use GeneralTrait;

    public function configuration()
    {
        try {
            $user = auth('sanctum')->user();

            $current_time = Carbon::now();

            $upcomingAppointments = $user->doctorProcesses()
                ->where('date', '>=', $current_time)
                ->get();

            $completedAppointments = $user->doctorProcesses()
                ->where('date', '<', $current_time)
                ->paginate(7);

            $user = StudentResource::make($user, $upcomingAppointments, $completedAppointments);

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
