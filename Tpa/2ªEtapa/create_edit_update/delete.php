<?php

$id = $_POST['id'] ?? null;

var_dump($_POST);

require_once "conexao.php";
$preparo = $conexao->prepare("DELETE FROM vagas_emprego WHERE id=?");
$preparo->execute([$id]); 

header("Location: index.php");


