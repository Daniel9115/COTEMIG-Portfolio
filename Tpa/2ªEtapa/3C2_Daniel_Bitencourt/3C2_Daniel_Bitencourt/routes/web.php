<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});


Route::get("/movels", [\App\Http\Controllers\MovelController::class, 'index']);

Route::get("/movels/create", function () {
    return view('movels.create');
});
