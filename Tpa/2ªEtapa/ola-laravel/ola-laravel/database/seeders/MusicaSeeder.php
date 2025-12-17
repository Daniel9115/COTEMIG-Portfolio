namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Musica;

class MusicaSeeder extends Seeder
{
    public function run()
    {
        Musica::create([
            'nome' => 'Bohemian Rhapsody',
            'artista' => 'Queen',
            'duracao' => 354,
        ]);

        Musica::create([
            'nome' => 'Imagine',
            'artista' => 'John Lennon',
            'duracao' => 183,
        ]);

        Musica::create([
            'nome' => 'Smells Like Teen Spirit',
            'artista' => 'Nirvana',
            'duracao' => 301,
        ]);
    }
}
