<?php
    function getPokemonAndPrintImg($url) {
        $resposta = file_get_contents($url);
        $decored = json_decode($resposta, true);
        $url_imagem = $decored['sprites']['front_default'];
        echo "<img style='width: 300px' src='$url_imagem'/>";
    }

    $url = 'https://pokeapi.co/api/v2/pokemon/';
    $resposta = file_get_contents($url);
    $decoded = json_decode($resposta, true);
    $lista_pokemons = $decoded['results'];

    foreach($lista_pokemons as $pokemon){
        print_r($pokemon['name'] . '<br/>');
        getPokemonAndPrintImg($pokemon['url']);
    }

?>