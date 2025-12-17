<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});
Route::get('/hello', function () {
    $APP_ENV_VAR = env('APP_ENV', '');
    return "<h1> Rodando no ambiente $APP_ENV_VAR </h1>";
});
Route::get('/hello-view', function () {
    $params = [
        'titulo' => 'Loja Online',
        'marca' => 'All Star'
    ];
    $titulo = 'Loja Online';
    $marca = 'All Star';
    $params2 = compact('titulo', 'marca');
    return view('hello', $params2);
});

Route::get('/exercicio1', function () {
    return view('exercicio1', [
        'musica' => 'My Life',
        'album' => 'Mama’s Gun',
        'artista' => 'Eryka Badu'
    ]);
});
