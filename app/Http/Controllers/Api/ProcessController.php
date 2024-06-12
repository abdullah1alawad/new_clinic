<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Clinic;
use App\Models\Patient;
use App\Models\Patient_question;
use App\Models\Subject;
use App\Models\User;
use Illuminate\Http\Request;
use App\traits\GeneralTrait;

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

    public function get_info($id)
    {
        try {
            $questions = Patient_question::where('clinic_id', $id)->get();
            $subjects = Subject::where('clinic_id', $id)->get();

            $doctorIds = $subjects->pluck('doctor_id');
            $doctors = User::whereIn('id', $doctorIds)->get();

            return $this->apiResponse([
                'questions' => $questions, 'subjects' => $subjects, 'doctors' => $doctors
            ], true, 'questions and subjects and doctors.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
    }

    public function get_chairs($id)
    {
        try {


        } catch (\Exception $ex) {
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
