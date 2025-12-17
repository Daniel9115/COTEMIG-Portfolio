<?php
    $user = "root";
    $host = "127.0.0.1";
    $psw = "";
    $dbname = "sakila";

    #$connection = new PDO("mysql:host=$host;dbname:$dbname", $user, $psw);
    $connection = new PDO("mysql:host=127.0.0.1;dbname=sakila", "root");
?>

<form method="post">
    <input name="nome_artista">
    <button type="submit">Criar</button>
</form>

<?php
if (isset($_POST["nome_artista"])) {
    $nome_artista = $_POST["nome_artista"];
    $statement = $connection -> prepare("INSERT INTO actor (first_name) VALUES (?);");
    $statement-> execute([$nome_artista]);
}

?>


<table border="1px">

    <?php
    $user = "root";
    $host = "127.0.0.1";
    $psw = "";
    $dbname = "sakila";

    #$connection = new PDO("mysql:host=$host;dbname:$dbname", $user, $psw);
    $connection = new PDO("mysql:host=127.0.0.1;dbname=sakila", "root");

    $actors = $connection->query("SELECT first_name FROM actor");
    foreach ($actors as $actor) {
        echo "<tr>";
        echo "<td>";
        echo "Nome: " . $actor["first_name"];
        echo "</td>";
        echo "</tr>";
    }
    ?>
</table>