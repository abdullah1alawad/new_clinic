<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use App\Models\Process;
use App\Models\User;
use App\Notifications\AssistantBookChair;
use App\Notifications\ChairBookRequestNotification;
use App\Notifications\DoctorDecisionBookChair;
use Illuminate\Http\Request;
use App\traits\GeneralTrait;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Validator;

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

            ///TODO i will send the notifications
            $notifications = $user->notifications()
                ->orderBy('created_at', 'desc')
                ->get();

            $user = StudentResource::make($user, $upcomingAppointments, $completedAppointments,$notifications);

            return $this->apiResponse($user, true, 'configuration data.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function acceptBookChairRequest(Request $request)
    {
        $rules = [
            'process_id' => 'required|exists:processes,id',
            'assistant_id' => 'nullable',
            'decision' => 'required|boolean',
        ];

        $messages = [
            'decision.required' => 'The decision is required.',
            'decision.boolean' => 'The decision must be a boolean.',
            'process_id.required' => 'The process_id is required.',
            'process_id.exists' => 'This process does not exists.',
        ];
        $validator = Validator::make($request->all(), $rules, $messages);

        if ($validator->fails())
            return $this->apiResponse(null, false, $validator->errors(), 422);

        $process = Process::find($request->process_id);

        $student = User::find($process->student_id);

        if ($request->decision) {
            $assistant = User::find($request->assistant_id);

            if (!$assistant || !$assistant->isAssistant()) {
                return $this->apiResponse(null, false,
                    'The selected user is not a valid assistant.', 422);
            }

            $process->status = 1;
            $process->assistant_id = $request->assistant_id;
            $process->save();

            $message = 'the doctor accept your request.';
            $student->notify(new DoctorDecisionBookChair($process, $message));
            $assistant->notify(new AssistantBookChair($process));
            return $this->apiResponse(null, true, 'the process is accepted.');
        }

        $message = 'the doctor reject your request.';
        $process->status = 0;
        $process->save();
        $student->notify(new DoctorDecisionBookChair($process, $message));
        return $this->apiResponse(null, true, 'this process is rejected.');

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
