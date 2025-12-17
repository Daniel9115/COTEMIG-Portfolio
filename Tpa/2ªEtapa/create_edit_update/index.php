<?php
$host = '127.0.0.1';
$banco = 'tpa_e1_pf';
$string_conn = "mysql:host=$host;dbname=$banco";
$user = 'root';
$password = '';
$pdo = new PDO($string_conn, $user, $password);


if (isset($_POST['nome'], $_POST['senioridade'], $_POST['descricao'])) {
    createEmprego($_POST['nome'], $_POST['senioridade'], $_POST['descricao']);
}
function getEmpregos()
{
    global $pdo;
    $stmt = $pdo->query('SELECT * from vagas_emprego');
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function createEmprego($nome, $senioridade, $descricao)
{
    global $pdo;
    $stmt = $pdo->prepare("INSERT INTO vagas_emprego (nome, senioridade, descricao) VALUES (?, ?, ?);");
    $stmt->execute([$nome, $senioridade, $descricao]);
}


$lista_empregos = getEmpregos();

?>
<form action="index.php" method="post">
    <input type="text" name="nome" placeholder="nome">
    <input type="text" name="senioridade" placeholder="senioridade">
    <input type="text" name="descricao" placeholder="descricao">
    <button type="submit">Criar</button>
</form>

<table border="1px">
    <tr>
    <th>Id</th>
    <th>Nome</th>
    <th>Senioridade</th>
        <th>Descricao</th>
        <th>Delete</th>
    </tr>

    <?php foreach ($lista_empregos as $empregos): ?>
        <tr>
            <td>
                <input type="text" name="" id="" value="<?= $empregos['id'] ?>">
            </td>
            <td>
                <input type="text" name="" id="" value="<?= $empregos['nome'] ?>">
            </td>
            <td>
                <input type="text" name="" id="" value="<?= $empregos['senioridade'] ?>">
            </td>
            <td>
                <input type="text" name="" id="" value="<?= $empregos['descricao'] ?>">
            </td>
            <td>
                <form action="edit.php" method="post">
                    <button type="submit">
                        Edit
                    </button>
                </form>
            </td>
            <td>
                <form action="delete.php" method="post">
                    <input hidden type="text" name="id" value="<?= $empregos['id'] ?>">
                    <button type="submit">
                        X
                    </button>
                </form>
            </td>
        </tr>
    <?php endforeach ?>
</table>