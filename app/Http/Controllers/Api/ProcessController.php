<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Chair;
use App\Models\Clinic;
use App\Models\Patient_question;
use App\Models\Process;
use App\Models\Subject;
use App\Models\User;
use App\Models\User_schedule;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use App\traits\GeneralTrait;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class ProcessController extends Controller
{
    use GeneralTrait;

    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $clinic = Clinic::all();
            return $this->apiResponse($clinic, true, 'all clinics');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function get_info($clinic_id)
    {
        try {
            $questions = Patient_question::where('clinic_id', $clinic_id)->get();
            $subjects = Subject::where('clinic_id', $clinic_id)->get();

            $doctors = User::whereHas('roles', function ($q) {
                $q->where('name', 'doctor');
            })->select('id', 'name')->get();

//            $doctorIds = $subjects->pluck('doctor_id'); // maybe multi doctors give this subject
//            $doctors = User::whereIn('id', $doctorIds)->get();

            return $this->apiResponse([
                'questions' => $questions, 'subjects' => $subjects, 'doctors' => $doctors
            ], true, 'questions and subjects and doctors.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function get_chairs($doctor_id, $clinic_id)
    {
        try {

            $doctorExists = User::where('id', $doctor_id)
                ->whereHas('roles', function ($q) {
                    $q->where('name', 'doctor');
                })->exists();
            if (!$doctorExists)
                return $this->notFoundMessage('the doctor');

            $clinicExists = Clinic::where('id', $clinic_id)->exists();
            if (!$clinicExists)
                return $this->notFoundMessage('the clinic');

            $current_time = Carbon::now();

            $doctor_schedule = User_schedule::where('user_id', $doctor_id)->first();

            $subjectIds = Subject::where('clinic_id', $clinic_id)->pluck('id');

            // maybe some subjects gives in multi clinics

            $upcomingAppointments = Process::whereIn('subject_id', $subjectIds)
                ->where('date', '>=', $current_time)
                ->where('status', '>', 0)
                ->select('date', 'chair_id')
                ->get();

            $chairs = Chair::where('clinic_id', $clinic_id)->select('id', 'chair_number')->get();

            $t[1] = Carbon::parse('09:00 am');
            $t[2] = Carbon::parse('10:30 am');
            $t[3] = Carbon::parse('12:00 pm');
            $t[4] = Carbon::parse('01:30 pm');

            $scheduleForMonth = [];

            for ($i = 0; $i < 30; $i++) {
                $date = $current_time->copy()->addDays($i)->toDateString();

                for ($j = 1; $j <= 4; $j++) {
                    if ($current_time <= $t[$j])
                        $scheduleForMonth[$date][$t[$j]->format('h:i A')] = 1;
                    else
                        $scheduleForMonth[$date][$t[$j]->format('h:i A')] = 0;
                }
            }

            if (isset($doctor_schedule)) {
                foreach ($doctor_schedule->time_of_work as $key1 => $value) {
                    $dayFromDoctorSchedule = $this->getDayByNumber($key1);
                    foreach ($scheduleForMonth as $date => &$times) {
                        $dayFromMonthSchedule = $this->getDayByDate($date);

                        if ($dayFromMonthSchedule == 'Friday') {
                            foreach ($times as &$time)
                                $time = 0;
                        } else if ($dayFromDoctorSchedule == $dayFromMonthSchedule) {

                            if (empty($value)) {
                                foreach ($times as &$time)
                                    $time = 0;
                            } else {
                                $startWork = strtotime($value[0]);
                                $endWork = strtotime($value[1]);

                                foreach ($times as $key2 => &$time) {

                                    $appointmentTime = strtotime($key2);
                                    if ($appointmentTime < $startWork || $appointmentTime >= $endWork)
                                        $time = 0;
                                }
                            }
                        }
                    }
                }
            }

            $help [][] = 0;
            foreach ($upcomingAppointments as $appointment) {
                $appointmentDate = Carbon::parse($appointment->date)->toDateString();
                $appointmentTime = Carbon::parse($appointment->date)->format('h:i A');

                if (isset($help[$appointmentDate][$appointmentTime]))
                    $help[$appointmentDate][$appointmentTime]++;
                else
                    $help[$appointmentDate][$appointmentTime] = 1;

                if (isset($scheduleForMonth[$appointmentDate][$appointmentTime]) &&
                    $help[$appointmentDate][$appointmentTime] >= $chairs->count())
                    $scheduleForMonth[$appointmentDate][$appointmentTime] = 0;
            }

            return $this->apiResponse($scheduleForMonth, true, 'appointments.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function book_chair(Request $request) // validation -- questions --
    {
        DB::beginTransaction();
        try {

            $validatedData = $request->validate([
                'clinic_id' => 'required|integer|exists:clinics,id',
                'date' => 'required|date',
                'doctor_id' => 'required|integer',
                'subject_id' => 'required|integer',
                'questions' => 'required|array',
                'questions.*.id' => 'required|integer|exists:patient_questions,id',
                'questions.*.answer' => 'required|string',
            ]);

            $subjectIds = Subject::where('clinic_id', $request->clinic_id)->pluck('id');

            $allSameTimeAppointmentsChairs = Process::whereIn('subject_id', $subjectIds)
                ->where('date', $request->date)
                ->where('status', '>', 0)
                ->pluck('chair_id')
                ->toArray();

            $chairIds = Chair::where('clinic_id', $request->clinic_id)->pluck('id');

//            $availableChairs = $chairIds->filter(function ($chairId) use ($allSameTimeAppointmentsChairs) {
//                return !in_array($chairId, $allSameTimeAppointmentsChairs);
//            })->values();

            $firstAvailableChair = $chairIds->first(function ($chairId) use ($allSameTimeAppointmentsChairs) {
                return !in_array($chairId, $allSameTimeAppointmentsChairs);
            });

            if (is_null($firstAvailableChair))
                return $this->notFoundMessage('no chairs available.');

            $photoPath = null;
            if ($request->hasFile('photo'))
                $photoPath = $this->saveImage($request->file('photo'), 'images');

            $process = new Process;
            $process->student_id = auth('sanctum')->user()->id;
            $process->doctor_id = $request->doctor_id;
            $process->chair_id = $firstAvailableChair;
            $process->subject_id = $request->subject_id;
            $process->questions = $request->questions;
            $process->date = $request->date;
            $process->photo = $photoPath;
            $process->status = 1;
            $process->save();

            DB::commit();
            return $this->apiResponse(null, true, 'The process has been stored successfully.');

        } catch (\Exception $ex) {
            DB::rollBack();

            if (isset($photoPath)) {
                $photoFullPath = public_path($photoPath);

                if (file_exists($photoFullPath))
                    unlink($photoFullPath);
            }

            Log::error('Error storing process: ' . $ex->getMessage());
            return $this->internalServer($ex->getMessage());
        }

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
