<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\PatientRequest;
use App\Http\Resources\PatientResource;
use App\Models\Disease;
use App\Models\Medicine;
use App\Models\Patient;
use App\traits\GeneralTrait;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PatientController extends Controller
{
    use GeneralTrait;

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
    public function store(PatientRequest $request)
    {
        DB::beginTransaction();

        try {
            $photoPath = $this->saveImage($request->file('signature'), 'images/');

            $patient = Patient::create([
                'name' => $request->input('name'),
                'gender' => $request->input('gender'),
                'national_id' => $request->input('national_id'),
                'birth_date' => $request->input('birth_date'),
                'height' => $request->input('height'),
                'weight' => $request->input('weight'),
                'address' => $request->input('address'),
                'job' => $request->input('job'),
                'phone' => $request->input('phone'),
                'questions' => $request->input('questions'),
                'last_medical_scan_date' => $request->input('last_medical_scan_date'),
                'personal_doctor_name' => $request->input('personal_doctor_name'),
                'currently_disease' => $request->input('currently_disease'),
                'skin_disease' => $request->input('skin_disease'),
                'skin_surgery' => $request->input('skin_surgery'),
                'reason_to_go_hospital' => $request->input('reason_to_go_hospital'),
                'reason_to_transform_blood' => $request->input('reason_to_transform_blood'),
                'skin_tooth_disease' => $request->input('skin_tooth_disease'),
                'reason_to_came' => $request->input('reason_to_came'),
                'signature' => $photoPath,
            ]);

            if ($request->has('other_diseases')) {
                $otherDiseases = $request->input('other_diseases');

                foreach ($otherDiseases as $diseaseName) {
                    $diseaseRow = new Disease();
                    $diseaseRow->name = $diseaseName;
                    $patient->diseases()->save($diseaseRow);
                }
            }

            if ($request->has('other_medicines')) {
                $otherMedicines = $request->input('other_medicines');

                foreach ($otherMedicines as $medicineName) {
                    $medicineRow = new Medicine();
                    $medicineRow->name = $medicineName;
                    $patient->medicines()->save($medicineRow);
                }
            }

            DB::commit();
            return $this->apiResponse(null, true, 'The patient has been added successfully.');

        } catch (\Exception $ex) {
            DB::rollBack();

            if (isset($photoPath)) {
                $photoFullPath = public_path($photoPath);

                if (file_exists($photoFullPath))
                    unlink($photoFullPath);
            }

            Log::error('Error storing patient: ' . $ex->getMessage());

            return $this->internalServer($ex->getMessage());
        }
    }


    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        try {
            $patient = Patient::with(['diseases', 'medicines'])->find($id);

            if (isset($patient))
                return $this->apiResponse(null, false, 'cant find this patient.', 404);

            $patient = PatientResource::make($patient);

            return $this->apiResponse($patient, true, 'this is the patient information.');

        } catch (\Exception $ex) {
            return $this->internalServer($ex->getMessage());
        }
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
