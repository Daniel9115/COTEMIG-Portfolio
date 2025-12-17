<!DOCTYPE html>
<html>
<head>
    <title>Lista de Tarefas</title>
</head>
<body>
<h1>Lista de Tarefas</h1>

@if(session('success'))
    <p style="color: green;">{{ session('success') }}</p>
@endif

<a href="{{ url('/tasks/create') }}">Criar nova tarefa</a>

<table border="1" cellpadding="5">
    <thead>
    <tr>
        <th>ID</th>
        <th>Título</th>
        <th>Descrição</th>
        <th>Status</th>
    </tr>
    </thead>
    <tbody>
    @foreach($tasks as $task)
        <tr>
            <td>{{ $task->id }}</td>
            <td>{{ $task->title }}</td>
            <td>{{ $task->description }}</td>
            <td>{{ $task->status }}</td>
        </tr>
    @endforeach
    </tbody>
</table>
</body>
</html>
