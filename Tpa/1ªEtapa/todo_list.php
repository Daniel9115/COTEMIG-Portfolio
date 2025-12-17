<?php
$conncetion = new PDO('sqlite:db.sqlite', SQLITE3_OPEN_CREATE | SQLITE3_OPEN_READWRITE);
if (isset($_POST['todo_name'])) {
    $todo_name = $_POST['todo_name'];
    //$conncetion->query("insert into todo (name) values ('$todo_name')");
    $statement = $conncetion -> prepare("insert into todo (name) values (?);");
    $statement -> execute([$todo_name]);
}
    
//$conncetion = new PDO('mysql://user:password')
$conncetion->query(
    'create table if not exists "todo"(
        "id" integer primary key autoincrement not null,
        "name" text
        )'
);
/*  $conncetion -> query("insert into todo values (1, 'maracatu')");
    $conncetion -> query("insert into todo values (2, 'maracatu')");
    $conncetion -> query("insert into todo values (3, 'maracatu')");
    $conncetion -> query("insert into todo values (4, 'maracatu')");  */
$result = $conncetion->query("select * from todo");
$parsed_result = $result->fetchAll(PDO::FETCH_ASSOC);
/*     var_dump($parsed_result)*/
?>
<form method="post">
    <input type="text" name="todo_name">
    <button type="submit">Criar</button>
</form>
<ul>
    <?php foreach ($parsed_result as $todo): ?>
        <?php echo "id: " . $todo['id'] ?>
        <li><?php echo $todo['name'] ?></li>
    <?php endforeach; ?>
</ul>