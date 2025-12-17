<h1>Produtos</h1>

@if(!count($products))
    <h2>Produtos não encontrados</h2>
@endif
<ul>

@foreach($products as $product)
    <li>
    {{$product->name}}: {{$product->description}} ({{$product->price}})
    </li>
@endforeach
</ul>
