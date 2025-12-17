<?php
    /* function getPokemonAndPrintImg($url) {
        $resposta = file_get_contents($url);
        $decored = json_decode($resposta, true);
        $url_imagem = $decored[0][0];
        echo "<img style='width: 300px' src='$url_imagem'/>";
    } */

    $url = 'https://api.thecatapi.com/v1/images/search?limit=10';
    $resposta = file_get_contents($url);
    $decoded = json_decode($resposta, true);
    var_dump($decoded);

    for ($i=0; $i < 10; $i++) { 
        $url_imagem = $decoded[$i]['url'];
        echo "<img style='width: 300px' src='$url_imagem'/>";
    }

    /* foreach($lista_pokemons as $pokemon){
        print_r($pokemon['name'] . '<br/>');
        getPokemonAndPrintImg($pokemon['url']);
    } */
?>