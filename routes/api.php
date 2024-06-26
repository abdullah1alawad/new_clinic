<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PatientController;
use App\Http\Controllers\Api\ProcessController;
use App\Http\Controllers\Api\StudentController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
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

//--------------------------------auth -------------------------------------

Route::post('/login', [AuthController::class, 'login'])->name('login');
Route::get('/configuration', [AuthController::class, 'configuration']);

//----------------------------------------------------------------------------------


//--------------------------------------patient----------------------------------
Route::group(['prefix' => 'patient'], function () {
    Route::post('/store', [PatientController::class, 'store'])->name('patient.store');
    Route::get('/show/{id}', [PatientController::class, 'show'])->name('patient.show');

});
//---------------------------------------------------------------------------------------


//------------------------------------student---------------------------------
Route::group(['prefix' => 'student'], function () {

});
//----------------------------------------------------------------------------


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

});


//--------------------------------------------------------------------------


// send clinics
// he will send the clinic id
// will send questions and subjects and doctors
//send the doctor who choose
//see the doctor empty and chairs


// subject will have doctor and clinic will have subjects
