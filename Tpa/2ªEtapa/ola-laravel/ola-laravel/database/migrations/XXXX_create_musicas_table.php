public function up()
{
    Schema::create('musicas', function (Blueprint $table) {
        $table->id();
        $table->string('nome');
        $table->string('artista');
        $table->integer('duracao');
        $table->timestamps();
    });
}
