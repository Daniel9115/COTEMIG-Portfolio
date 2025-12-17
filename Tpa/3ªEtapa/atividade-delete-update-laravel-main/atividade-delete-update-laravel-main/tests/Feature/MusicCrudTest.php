<?php

namespace Tests\Feature;

use App\Models\Music;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class MusicCrudTest extends TestCase
{
    use RefreshDatabase;

    public function test_edit_view_displays_music_data()
    {
    $music = Music::factory()->create();
    $response = $this->get("musics/{$music->id}/edit");
    $response->assertStatus(200);
    $response->assertSee($music->title);
    $response->assertSee($music->artist);
    }

    public function test_update_music()
    {
        $music = Music::factory()->create();
        $newData = [
            'title' => 'Updated Title',
            'artist' => 'Updated Artist',
            'album' => 'Updated Album',
            'year' => 2020,
            'genre' => 'Updated Genre',
        ];
        $response = $this->put("musics/{$music->id}", $newData);
        $response->assertRedirect(route('music.index'));
        $this->assertDatabaseHas('music', $newData);
    }

    public function test_delete_music()
    {
    $music = Music::factory()->create();
    $response = $this->delete("musics/{$music->id}");
    $response->assertRedirect(route('music.index'));
    $this->assertDatabaseMissing('music', ['id' => $music->id]);
    }
}
