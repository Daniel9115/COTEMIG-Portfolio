<div>
    <form action="/movels" method="POST">
        @csrf
        <label for="tipo">Tipo:</label><br>
        <input type="text" id="tipo" name="tipo" required><br><br>

        <label for="material">Material:</label><br>
        <input type="text" id="material" name="material" required><br><br>

        <label for="descricao">Descrição:</label><br>
        <textarea id="descricao" name="descricao" rows="4" cols="50"></textarea><br><br>

        <input type="submit" value="Enviar">
    </form>
</div>
