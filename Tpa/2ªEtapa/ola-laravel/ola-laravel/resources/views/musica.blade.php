<!DOCTYPE html>
<html>
<head>
    <title>Lista de Músicas</title>
</head>
<body>
    <h1>Músicas</h1>
    <ul>
        @foreach($musicas as $musica)
            <li>{{ $musica->nome }} - {{ $musica->artista }}</li>
        @endforeach
    </ul>
</body>
</html>
