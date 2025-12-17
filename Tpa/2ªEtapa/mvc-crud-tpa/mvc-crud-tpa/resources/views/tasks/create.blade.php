<!DOCTYPE html>
<html>
<head>
    <title>Criar Tarefa</title>
</head>
<body>
<h1>Criar Nova Tarefa</h1>

@if($errors->any())
    <div style="color: red;">
        <ul>
            @foreach($errors->all() as $erro)
                <li>{{ $erro }}</li>
            @endforeach
        </ul>
    </div>
@endif

<form action="{{ url('/tasks') }}" method="POST">
    @csrf
    <label for="title">Título:</label><br>
    <input type="text" name="title" id="title" value="{{ old('title') }}"><br><br>

    <label for="description">Descrição:</label><br>
    <textarea name="description" id="description">{{ old('description') }}</textarea><br><br>

    <label for="status">Status:</label><br>
    <select name="status" id="status">
        <option value="pendente" {{ old('status') == 'pendente' ? 'selected' : '' }}>Pendente</option>
        <option value="em progresso" {{ old('status') == 'em progresso' ? 'selected' : '' }}>Em Progresso</option>
        <option value="concluída" {{ old('status') == 'concluída' ? 'selected' : '' }}>Concluída</option>
    </select><br><br>

    <button type="submit">Salvar</button>
</form>
</body>
</html>
