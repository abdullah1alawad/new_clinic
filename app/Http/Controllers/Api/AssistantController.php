<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Process;
use App\Models\User;
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

        return $this->getDayByNumber(3);

        $assistants = User::whereHas('roles', function ($query) {
            $query->where('name', 'assistant');
        })->get();


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
