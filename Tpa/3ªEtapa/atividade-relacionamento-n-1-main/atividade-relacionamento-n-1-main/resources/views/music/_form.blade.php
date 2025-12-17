<div class="mb-3">
    <label for="title" class="form-label">Title</label>
    <input type="text" name="title" id="title" class="form-control" value="{{ old('title', isset($music) ? $music->title : '') }}" required>
    @error('title')<div class="text-danger">{{ $message }}</div>@enderror
</div>
<div class="mb-3">
    <label for="artist" class="form-label">Artist</label>
    <input type="text" name="artist" id="artist" class="form-control" value="{{ old('artist', isset($music) ? $music->artist : '') }}" required>
    @error('artist')<div class="text-danger">{{ $message }}</div>@enderror
</div>
<div class="mb-3">
    <label for="album" class="form-label">Album</label>
    <input type="text" name="album" id="album" class="form-control" value="{{ old('album', isset($music) ? $music->album : '') }}">
    @error('album')<div class="text-danger">{{ $message }}</div>@enderror
</div>
<div class="mb-3">
    <label for="year" class="form-label">Year</label>
    <input type="number" name="year" id="year" class="form-control" value="{{ old('year', isset($music) ? $music->year : '') }}">
    @error('year')<div class="text-danger">{{ $message }}</div>@enderror
</div>
<div class="mb-3">
    <label for="genre" class="form-label">Genre</label>
    <input type="text" name="genre" id="genre" class="form-control" value="{{ old('genre', isset($music) ? $music->genre : '') }}">
    @error('genre')<div class="text-danger">{{ $message }}</div>@enderror
</div>
