Restaurantes

<div>
    @if ($restaurants)
        @foreach ($restaurants as $restaurant)
        <div>
            <p>
            {{ $restaurant->name }} 
                 </p>
                 <p>
        Nota: {{ $restaurant->rating }} 
         </p>
            <p>
            Categoria: {{ $restaurant->type }} 
            </p>
        </div>
        @endforeach

    @endif
</div>
