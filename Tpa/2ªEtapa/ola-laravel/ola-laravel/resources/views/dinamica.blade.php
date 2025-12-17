<h1>{{$titulo}}</h1>

@if($logado)
    <p>Usuário logado</p>
@endif

@foreach($musicas as $musica)

    <li>{{$musica}}</li>
@endforeach
