<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use App\Http\Resources\UpcomingAppointmentsResource;
use App\Http\Resources\UserResource;
use App\Models\Process;
use App\Models\User;
use App\Models\User_schedule;
use App\traits\GeneralTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Validator;

class AssistantController extends Controller
{
    use GeneralTrait;

    public function getAvailableAssistants(Request $request)
    {
        $rules = [
            'process_id' => 'required|exists:processes,id',
        ];

        $messages = [
            'process_id.required' => 'The process_id is required.',
            'process_id.exists' => 'This process does not exists.',
        ];
        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails())
            return $this->apiResponse(null, false, $validator->errors(), 422);

        $process = Process::find($request->process_id);
        $dayOfProcess = $this->getDayByDate($process->date);

        $assistants = User::whereHas('roles', function ($query) {
            $query->where('name', 'assistant');
        })->get();

        $processTime = $process->date;
        $processTime = $processTime->format('H:i');

        $AvailableAssistantsBySchedule = [];

        foreach ($assistants as $assistant) {
            $user_schedule = User_schedule::where('user_id', $assistant->id)->first();

            if ($user_schedule) {
                foreach ($user_schedule->time_of_work as $key => $time) {
                    $dayOfSchedule = $this->getDayByNumber($key);
                    if ($dayOfProcess == $dayOfSchedule &&
                        ($processTime >= $time[0] && $processTime < $time[1])) {
                        $AvailableAssistantsBySchedule[] = $assistant;
                    }
                }
            } else {
                $AvailableAssistantsBySchedule[] = $assistant;
            }
        }
//        return $AvailableAssistantsBySchedule;

        $AvailableAssistants = [];
        foreach ($AvailableAssistantsBySchedule as $item) {

            $checkAssistantProcessTime = Process::where('date', $process->date)
                ->where('assistant_id', $item->id)->exists();
            if (!$checkAssistantProcessTime)
                $AvailableAssistants[] = $item;
        }

        $process = UpcomingAppointmentsResource::make($process);
        $AvailableAssistants = UserResource::collection($AvailableAssistants);

        return $this->apiResponse([
            'assistants' => $AvailableAssistants,
            'process' => $process,
        ], true, 'all Available Assistants.');

    }

    public function configuration()
    {
        try {
            $user = auth('sanctum')->user();

            $current_time = Carbon::now();

            $upcomingAppointments = $user->assistantProcesses()
                ->where('date', '>=', $current_time)
                ->get();

            $completedAppointments = $user->assistantProcesses()
                ->where('date', '<', $current_time)
                ->paginate(7);

            ///TODO i will send the notifications
            $notifications = $user->notifications()
                ->orderBy('created_at', 'desc')
                ->get();

            $user = StudentResource::make($user, $upcomingAppointments, $completedAppointments, $notifications);

            return $this->apiResponse($user, true, 'configuration data.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }
}
