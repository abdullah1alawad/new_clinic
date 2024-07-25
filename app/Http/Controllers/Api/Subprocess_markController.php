<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Process;
use App\Models\Student_mark;
use App\Models\Subprocess_mark;
use App\traits\GeneralTrait;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class Subprocess_markController extends Controller
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
    public function store(Request $request)
    {
        DB::beginTransaction();
        try {
            $rules = [
                'process_id' => 'required|exists:processes,id',
                'name' => 'required|array',
                'name.*' => 'string',
                'mark' => 'required|array',
                'mark.*' => 'numeric'
            ];

            $messages = [
                'name.required' => 'The sub-process name is required.',
                'name.*.string' => 'The name must be a string.',
                'mark.required' => 'The sub-mark filed is required.',
                'mark.*.numeric' => 'The sub-mark can contain numbers only.',
                'process_id.required' => 'The process_id is required.',
                'process_id.exists' => 'This process does not exists.',
            ];

            $validator = Validator::make($request->all(), $rules, $messages);

            if ($validator->fails())
                return $this->apiResponse(null, false, $validator->errors(), 422);

            $process = Process::find($request->process_id);

            $subprocessData = [];
            $names = $request->input('name');
            $marks = $request->input('mark');

            for ($i = 0; $i < count($names); $i++) {
                $subprocessData[] = [
                    'name' => $names[$i],
                    'mark' => $marks[$i],
                ];
            }

            foreach ($subprocessData as $data) {
                $subProcessMark = new Subprocess_mark($data);
                $process->marks()->save($subProcessMark);
            }

            $subProcessMarks = $process->marks;
            $mark = 0;
            foreach ($subProcessMarks as $item) {
                $mark = $mark + $item->mark;
            }

            $process->mark = $mark;
            $process->save();

            Student_mark::create([
                'student_id' => $process->student_id,
                'subject_id' => $process->subject_id,
                'mark' => $process->mark
            ]);

            DB::commit();

            return $this->apiResponse($process->marks, true, 'sub-process data');

        } catch (\Exception $ex) {
            DB::rollBack();
            return $this->internalServer($ex->getMessage());
        }
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
    public function destroy(Request $request)
    {
        DB::beginTransaction();
        try {
            $rules = [
                'sub_process_id' => 'required|array',
                'sub_process_id.*' => 'exists:processes,id',
            ];

            $messages = [
                'sub_process_id.required' => 'The sub_process_id is required.',
                'sub_process_id.*.exists' => 'This sub_process_id does not exists.',
            ];

            $validator = Validator::make($request->all(), $rules, $messages);

            if ($validator->fails())
                return $this->apiResponse(null, false, $validator->errors(), 422);

            $subProcess_ids = $request->sub_process_id;
            foreach ($subProcess_ids as $subProcess_id) {
                $subProcess = Subprocess_mark::find($subProcess_id);
                $process = Process::find($subProcess->process_id);
                $process->mark = $process->mark - $subProcess->mark;
                $process->save();

                $student_mark = Student_mark::where('student_id', $process->student_id)
                    ->where('subject_id', $process->subject_id)->first();
                $student_mark->mark = $student_mark->mark - $subProcess->mark;
                $student_mark->save();

                $subProcess->delete();
            }
            DB::commit();
            return $this->apiResponse(null, true, 'the sub-process has been deleted.');

        } catch (\Exception $ex) {
            DB::rollBack();
            return $this->internalServer($ex->getMessage());
        }
    }
}
