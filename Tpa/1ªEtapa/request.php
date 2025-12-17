<form action="" methodo="get">
    <input type="text" name="pokemon" value="<?php echo $_GET['pokemon']; ?>" id="">
</form>

<?php
$pokemon = $_GET['pokemon'];
echo $pokemon;
$url = 'https://pokeapi.co/api/v2/pokemon/' . $pokemon;
var_dump($url);
$resposta = file_get_contents($url);
//var_dump($resposta);
$decoded = json_decode($resposta, true);
//var_dump($decoded);
$url_imagem = $decoded['sprites']['front_default'];
//echo $url_imagem;

echo "<img src='$url_imagem' />"

?>