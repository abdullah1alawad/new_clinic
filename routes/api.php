<?php

use App\Http\Controllers\Api\AssistantController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PatientController;
use App\Http\Controllers\Api\ProcessController;
use App\Http\Controllers\Api\StudentController;
use App\Http\Controllers\Api\DoctorController;
use App\Http\Controllers\ChatController;
use App\Http\Controllers\ChatMessageController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\Api\Subprocess_markController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Broadcast;
use Illuminate\Support\Facades\Route;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Broadcast::routes(['middleware' => ['auth:sanctum']]);

//--------------------------------auth -------------------------------------

Route::post('/login', [AuthController::class, 'login'])->name('login');
Route::post('/logout', [AuthController::class, 'logout']);

//----------------------------------------------------------------------------------


//--------------------------------------patient----------------------------------
Route::group(['prefix' => 'patient'], function () {
    Route::post('/store', [PatientController::class, 'store'])->name('patient.store');
    Route::get('/show/{id}', [PatientController::class, 'show'])->name('patient.show');

});
//---------------------------------------------------------------------------------------


//------------------------------------student---------------------------------
Route::group(['prefix' => 'student'], function () {
    Route::get('/configuration', [StudentController::class, 'configuration']);
});
//----------------------------------------------------------------------------

//--------------------------------------doctor-----------------------------------

Route::group(['prefix' => 'doctor'], function () {
    Route::get('/configuration', [DoctorController::class, 'configuration']);
    Route::post('/decision/book-chair', [DoctorController::class, 'decisionBookChairRequest']);
    Route::put('/update/decision/book-chair', [DoctorController::class, 'updateDecisionBookChairRequest']);
    Route::post('/add-marks', [Subprocess_markController::class, 'store']);
    Route::post('/delete-sub-process', [Subprocess_markController::class, 'destroy']);
});


Route::post('user/update', [UserController::class, 'update'])->name('user.update');
Route::put('user/reset-password', [UserController::class, 'resetPassword'])->name('user.resetPassword');

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//----------------------------------process---------------------------------

Route::group(['prefix' => 'process'], function () {
    Route::get('get-clinics', [ProcessController::class, 'index']);
    Route::get('get-info/{clinic_id}', [ProcessController::class, 'get_info']);
    Route::get('get-chairs/{doctor_id}/{clinic_id}', [ProcessController::class, 'get_chairs']);
    Route::post('book-chair', [ProcessController::class, 'book_chair']);
    Route::delete('delete-process/{process_id}', [ProcessController::class, 'destroy']);
    Route::get('search-patient', [ProcessController::class, 'patient_info_search']);
});

Route::group(['prefix' => 'assistant'], function () {
    Route::get('get-available-assistant', [AssistantController::class, 'getAvailableAssistants']);
    Route::get('configuration', [AssistantController::class, 'configuration']);
});

Route::apiResource('chat', ChatController::class)->only(['index', 'store', 'show']);
Route::apiResource('chat_message', ChatMessageController::class)->only(['index', 'store']);
Route::put('chat/read-it', [ChatController::class, 'makeRead']);
Route::apiResource('user', UserController::class)->only(['index']);

//--------------------------------------------------------------------------


// TODO----------------------------------------------
// student cant book more than one chair at same time
// check the delete process
// delete the old image in the update user
// check when assistant is booked at the same time from two users in the post function
// check the assistant if available in the post function
// see the diseases and medicines for the patient
// student marks table
//maybe the student fails and his data on the database duplicated like his marks on the same subject
// in the student resource in the mark you should check the appointments
