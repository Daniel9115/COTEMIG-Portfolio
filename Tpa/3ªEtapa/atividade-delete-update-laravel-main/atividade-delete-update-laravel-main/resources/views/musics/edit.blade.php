<form action="{{ route('music.update', $music->id) }}" method="POST">
    @csrf
    @method('PUT')
    <label for="title">Título:</label>
    <input type="text" name="title" value="{{ $music->title }}">
    <label for="artist">Artista:</label>
    <input type="text" name="artist" value="{{ $music->artist }}">
    <label for="album">Álbum:</label>
    <input type="text" name="album" value="{{ $music->album }}">
    <label for="year">Ano:</label>
    <input type="number" name="year" value="{{ $music->year }}">
    <label for="genre">Gênero:</label>
    <input type="text" name="genre" value="{{ $music->genre }}">
    <button type="submit">Salvar</button>
</form>