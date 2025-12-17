<?php  

    $url = 'https://api.thecatapi.com/v1/images/search?limit=10';
    $resposta = file_get_contents($url);
    var_dump($resposta);
    
    $lista_gatos = json_decode($resposta, true);
    //var_dump($lista_gatos);

    foreach($lista_gatos as $gato){
        echo "<img src='".$gato['url']."'>";
    } 
    
?>