<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class MusicSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
    $albumIds = \App\Models\Album::pluck('id');
    \App\Models\Music::factory(10)->create([
        'album_id' => $albumIds->random(),
    ]);
    }
}
