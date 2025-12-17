<?php

use Illuminate\Support\Facades\Route;


use App\Http\Controllers\MusicController;

Route::get('/', function () {
    return redirect()->route('music.index');
});

Route::get('/musics', [MusicController::class, 'index'])->name('music.index');
Route::get('/musics/create', [MusicController::class, 'create'])->name('music.create');
Route::post('/musics', [MusicController::class, 'store'])->name('music.store');
Route::get('/musics/{music}', [MusicController::class, 'show'])->name('music.show');
Route::get('/musics/{music}/edit', [MusicController::class, 'edit'])->name('music.edit');
Route::put('/musics/{music}', [MusicController::class, 'update'])->name('music.update');
Route::delete('/musics/{music}', [MusicController::class, 'destroy'])->name('music.destroy');