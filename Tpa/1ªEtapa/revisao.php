<?php
 $lista = [9,9,3,1,4,6,1];
 $lista_array= array(9,9,3,1,4,6,1);
 $primeiro_item = $lista[0];

$dicionario = [
    'chave' => 'valor',
    'sapo' => 'anfíbio que mora na lagoa'
];

echo "chave sapo tem valor: ". $dicionario['sapo'];
echo '<br/>';
if($lista[0] > $lista[1]){
    echo "Primeiro item maior que segundo";
} 
elseif($lista[0] < $lista[1]){
    echo "Segundo item maior que primeiro";
}
else {
 echo "Itens iguais";   
}
echo '<br/>';
$tamanho_lista = count($lista);
$tamanho_lista_array = count($lista_array);
echo "$tamanho_lista";   

if($tamanho_lista === $tamanho_lista_array){
    echo "listas tem mesmo tamanho";   
} 
if($tamanho_lista !== $tamanho_lista_array){
    echo "listas tem tamanho diferente";   
} 
$lista_vazia = [];
echo '<br/>';

echo "valor de ![] :" .!$lista_vazia;
echo '<br/>';
$lista = [9,9,3,1,4,6,1];
$lista_array= array(9,9,3,1,4,6,1);

if(!count($lista_vazia)){
    echo "lista vazia";
}
echo '<br/>';

$soma = 1 + 2;
$par = 11 % 2;
$num = 11;

echo '<br/>';

var_dump($par);


for($indice = 0; $indice < count($lista); $indice++){
    $item = $lista[$indice];
    echo "$item" . '<br/>';
}

foreach($lista as $item){
    if($item % 2 !== 0){
        echo "O número $item é impar";
    } else {
        echo "O número $item é par";
    }    
    echo '<br/>';
}

?>