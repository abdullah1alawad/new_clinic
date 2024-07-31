<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Resources\StudentResource;
use App\Models\Process;
use App\Models\Subprocess_mark;
use App\Models\User;
use App\Notifications\AssistantBookChair;
use App\Notifications\DoctorDecisionBookChair;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use App\traits\GeneralTrait;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
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

            $user = StudentResource::make($user, $upcomingAppointments, $completedAppointments, $notifications);

            return $this->apiResponse($user, true, 'configuration data.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function decisionBookChairRequest(Request $request)
    {
        DB::beginTransaction();
        try {
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

            $user = auth('sanctum')->user();

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

                $message = 'لقد قبل الدكتور هذا الموعد.';
                $cause = 'doctor_decision_book_chair_for_student';
                $student->notify(new DoctorDecisionBookChair($process, $message, $cause, $user));
                $assistant->notify(new AssistantBookChair($process, $user));
                DB::commit();
                return $this->apiResponse(null, true, 'the process is accepted.');
            }

            $message = 'لقد رفض الدكتور هذا الموعد.';
            $process->status = 0;
            $process->save();
            $cause = 'doctor_decision_book_chair_for_student';
            $student->notify(new DoctorDecisionBookChair($process, $message, $cause, $user));

            DB::commit();

            return $this->apiResponse(null, true, 'this process is rejected.');

        } catch (\Exception $ex) {
            DB::rollBack();
            return $this->internalServer($ex->getMessage());
        }
    }

    public function updateDecisionBookChairRequest(Request $request)
    {
        DB::beginTransaction();
        try {
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

            $user = auth('sanctum')->user();

            $process = Process::find($request->process_id);

            $student = User::find($process->student_id);

            if ($request->decision) {
                $assistant = User::find($request->assistant_id);

                $oldAssistant = null;
                if ($assistant) {
                    if ($process->assistant_id) {
                        $oldAssistant = User::find($process->assistant_id);
                        $oldAssistant->notify(new DoctorDecisionBookChair(
                            $process, 'لقد تم تغييرك من هذا الموعد.', 'doctor_choose_assistant', $user));
                    }
                    $process->assistant_id = $request->assistant_id;
                    $assistant->notify(new DoctorDecisionBookChair(
                        $process, 'لقد تم اختيارك من قبل الدكتور.', 'doctor_choose_assistant', $user));
                } else {
                    if (!$process->assistant_id) {
                        return $this->apiResponse(null, false,
                            'choose assistant for the process.', 422);
                    }
                }

                $process->status = 1;
                $process->save();

                $message = 'لقد قبل الدكتور طلبك لحجز موعد.';
                $cause = 'doctor_decision_book_chair_for_student';
                $student->notify(new DoctorDecisionBookChair($process, $message, $cause, $user));

                return $this->apiResponse(null, true, 'the process is accepted.');
            }

            $assistant = User::find($process->assistant_id);

            $message = 'لقد رفض الدكتور طلبك لحجز موعد.';
            $process->status = 0;
            $process->save();
            $cause = 'doctor_decision_book_chair_for_student';
            $student->notify(new DoctorDecisionBookChair($process, $message, $cause, $user));
            $message = 'لقد رفض الدكتور هذا الموعد.';
            $cause = 'doctor_decision_book_chair_for_assistant';
            $assistant->notify(new DoctorDecisionBookChair($process, $message, $cause, $user));

            DB::commit();

            return $this->apiResponse(null, true, 'this process is rejected.');

        } catch (\Exception $ex) {
            DB::rollBack();
            return $this->internalServer($ex->getMessage());
        }
    }


}
