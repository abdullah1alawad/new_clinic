<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\UpcomingAppointmentsResource;
use App\Models\Process;
use App\Models\User;
use App\Models\User_schedule;
use App\traits\GeneralTrait;
use Illuminate\Http\Request;
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
                        $AvailableAssistantsBySchedule[] = [
                            'id' => $assistant->id,
                            'name' => $assistant->name,
                        ];
                    }
                }
            }
        }

        $AvailableAssistants = [];
        foreach ($AvailableAssistantsBySchedule as $item) {

            $checkAssistantProcessTime = Process::where('date', $process->date)
                ->where('assistant_id', $item['id'])->exists();
            if (!$checkAssistantProcessTime)
                $AvailableAssistants[] = $item;
        }

        $process = UpcomingAppointmentsResource::make($process);


        return $this->apiResponse([
            'assistants' => $AvailableAssistants,
            'process' => $process,
        ], true, 'all Available Assistants.');

    }

    public function index()
    {

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
