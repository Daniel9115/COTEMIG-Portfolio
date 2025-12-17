Exercício:

Crie uma lista de strings de tamanhos diferentes, imprima a menor string da lista;

Dicas:
- Use a função strlen para encontrar o tamanho da string;
- Use uma variável auxiliar para guardar o valor da menor string atual;
<br />

<?php
$lista = ['sapo', 'uva', 'cinco', 'batata', 'maracatu'];

$menor_item = $lista[0];
echo "========= foreach ========== <br/>";
foreach ($lista as $item_atual) {
    $tamanho_item_atual = strlen($item_atual);
    $tamanho_menor_item = strlen($menor_item);

    echo "Menor item: $menor_item || Item atual: $item_atual <br/>";

    if ($tamanho_item_atual < $tamanho_menor_item) {
        $menor_item = $item_atual;
    }
}
$lista = ['sapo', 'uva', 'cinco', 'batata', 'maracatu'];
$menor_item = $lista[0];

echo "========= for raiz ========== <br/>";

for ($i = 1; $i < count($lista); $i++) {
    $item_atual = $lista[$i];
    $tamanho_item_atual = strlen($item_atual);
    $tamanho_menor_item = strlen($menor_item);
    echo "Menor item: $menor_item || Item atual: $item_atual <br/>";

    if ($tamanho_item_atual < $tamanho_menor_item) {
        $menor_item = $item_atual;
    }
}

echo "A string menor é $menor_item";
?>