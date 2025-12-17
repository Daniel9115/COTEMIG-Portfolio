<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Music extends Model
{
    /** @use HasFactory<\Database\Factories\MusicFactory> */
    use HasFactory;
    protected $table = "musics";

    protected $fillable = [
        'title',
        'artist',
        'album',
        'year',
        'genre',
    ];

    public function artists()
    {
        return $this->belongsToMany(Artist::class);
    }
}
