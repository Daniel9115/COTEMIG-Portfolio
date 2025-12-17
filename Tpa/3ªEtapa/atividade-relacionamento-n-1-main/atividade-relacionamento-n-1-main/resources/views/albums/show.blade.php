@extends('layouts.app')

@section('content')
    <h1>Detalhes do Álbum: {{ $album->name }}</h1>
    <p>Ano: {{ $album->year }}</p>
    <img src="{{ $album->url_img }}" alt="Capa do Álbum" width="100">

    <h2>Músicas</h2>
    <ul>
        @foreach ($musics as $music)
            <li>{{ $music->name }}</li>
        @endforeach
    </ul>
@endsection