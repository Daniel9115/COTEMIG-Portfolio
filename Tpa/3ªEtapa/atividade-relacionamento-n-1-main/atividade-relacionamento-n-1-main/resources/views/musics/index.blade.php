@extends('layouts.app')

@section('content')
    <h1>Lista de Músicas</h1>
    <table class="table table-bordered">
        <thead>
            <tr>
                <th>Título</th>
                <th>Artista</th>
                <th>Álbum</th>
                <th>Imagem</th>
                <th>Ano</th>
                <th>Gênero</th>
                <th>Ações</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($musics as $music)
                <tr>
                    <td>{{ $music->name }}</td>
                    <td>{{ $music->artist }}</td>
                    <td>{{ $music->album->name ?? 'Sem Álbum' }}</td>
                    <td><img src="{{ $music->album->url_img ?? '' }}" alt="Album cover" style="width: 50px; height: 50px;"></td>
                    <td>{{ $music->album->year ?? '-' }}</td>
                    <td>{{ $music->genre }}</td>
                    <td>
                        Ver
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
@endsection
