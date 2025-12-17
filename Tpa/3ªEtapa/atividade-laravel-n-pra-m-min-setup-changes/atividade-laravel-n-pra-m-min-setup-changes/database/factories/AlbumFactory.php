<?php

namespace Database\Factories;

use App\Models\Album;
use Illuminate\Database\Eloquent\Factories\Factory;

class AlbumFactory extends Factory
{
    protected $model = Album::class;

    public function definition(): array
    {
        return [
            'name' => $this->faker->words(2, true),
            'year' => $this->faker->year(),
            'url_img' => $this->faker->imageUrl(200, 200, 'album', true, 'Album'),
        ];
    }
}
