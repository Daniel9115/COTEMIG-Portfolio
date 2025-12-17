<?php
require_once "conexao.php";
$preparo = $conexao->prepare("INSERT INTO vagas_emprego (nome, senioridade, descricao) VALUES (?, ?, ?)");
$preparo->execute([$_POST['nome'], $_POST['senioridade'], $_POST['descricao']]);


header("Location: index.php");

?>

Animal criado com sucesso!

<a href="index.php">Voltar</a>