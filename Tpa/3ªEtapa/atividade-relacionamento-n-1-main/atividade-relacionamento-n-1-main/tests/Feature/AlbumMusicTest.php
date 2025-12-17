<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;
use App\Models\Album;
use App\Models\Music;
use Illuminate\Database\QueryException;
use PHPUnit\Framework\Attributes\Test;
use PHPUnit\Framework\Attributes\CoversClass;

class AlbumMusicTest extends TestCase
{
    use RefreshDatabase;
    #[Test]

    public function test_migration_albums_table_has_expected_columns_test()
    {
        Artisan::call('migrate');
        $this->assertTrue(Schema::hasTable('albums'));
        $this->assertTrue(Schema::hasColumns('albums', ['id', 'name', 'year', 'url_img', 'created_at', 'updated_at']));
    }
    #[Test]

    public function musics_table_has_album_id_foreign_key()
    {
        $this->assertTrue(Schema::hasColumn('musics', 'album_id'));

        // 2. Test the foreign key constraint
        // We expect an exception when we try to create a music
        // with an album_id that does not exist in the albums table.
        $this->expectException(QueryException::class);
    
        // This will try to insert a record with a non-existent album_id (e.g., 9999)
        Music::create([
            'album_id' => 9999,
            'name' => 'Test Music',
            'duration' => 180,
        ]);
    
    }
    #[Test]

    public function album_music_models_have_n_to_1_relationship()
    {
        $album = Album::factory()->create();
        $music = Music::factory()->create(['album_id' => $album->id]);
        $this->assertEquals($album->id, $music->album->id);
        $this->assertTrue($album->musics->contains($music));
    }
    #[Test]

    public function music_index_route_lists_album_name()
    {
        $album = Album::factory()->create();
        $music = Music::factory()->create(['album_id' => $album->id]);
        $response = $this->get('/musics');
        $response->assertStatus(200);
        $response->assertSee($album->name);
        $response->assertSee($album->url_img);
    }
    #[Test]

    public function album_show_lists_its_musics()
    {
        $album = Album::factory()->create();
        $music1 = Music::factory()->create(['album_id' => $album->id]);
        $music2 = Music::factory()->create(['album_id' => $album->id]);
        $response = $this->get('/albums/' . $album->id);
        $response->assertStatus(200);
        $response->assertSee($music1->name);
        $response->assertSee($music2->name);
    }
}
