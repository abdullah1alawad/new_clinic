<?php

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\PatientController;
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


