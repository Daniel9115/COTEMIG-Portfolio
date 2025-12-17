<?php

namespace App\Http\Controllers;

use App\Models\Album;
use Illuminate\Http\Request;

class AlbumController extends Controller
{
    public function show(Album $album)
    {
        $musics = $album->musics;
        return view('albums.show', compact('album', 'musics'));
    }
}