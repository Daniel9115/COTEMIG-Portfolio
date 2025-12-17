<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class AlbumSeeder extends Seeder
{
    public function run(): void
    {
        \App\Models\Album::factory(5)->create();
    }
}