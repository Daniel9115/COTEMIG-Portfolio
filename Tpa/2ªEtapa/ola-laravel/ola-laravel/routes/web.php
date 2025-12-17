use App\Models\Musica;
use Illuminate\Support\Facades\Route;

Route::get('/musicas', function () {
    $musicas = Musica::all();
    return view('musica', ['musicas' => $musicas]);
});
