<div>
    @if($movels)
        @foreach($movels as $movel)
            <p>
                {{$movel->id}} - {{$movel->tipo}} - {{$movel->material}} - {{$movel->descricao}}
            </p>
        @endforeach
    @else
        <p>Não encontrado</p>
    @endif
</div>
