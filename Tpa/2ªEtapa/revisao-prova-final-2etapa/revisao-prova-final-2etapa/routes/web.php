<?php

use App\Http\Controllers\RestaurantController;
use App\Models\Restaurant;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

Route::get("/restaurants", [RestaurantController::class, 'index']);

Route::get("/restaurants/create", [RestaurantController::class, 'create']);

Route::post("/restaurants", [RestaurantController::class, 'store']);
