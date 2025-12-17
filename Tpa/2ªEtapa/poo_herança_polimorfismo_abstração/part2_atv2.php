<?php
abstract class Audio
{
    public string $titulo;
    public int $duracao;

    public function __construct(string $titulo, int $duracao)
    {
        $this->titulo = $titulo;
        $this->duracao = $duracao;
    }

    abstract public function play(): void;
}

class Musica extends Audio
{
    public string $artista;
    public string $album;

    public function __construct(string $titulo, int $duracao, string $artista, string $album)
    {
        parent::__construct($titulo, $duracao);
        $this->artista = $artista;
        $this->album = $album;
    }

    public function play(): void
    {
        echo "Escutando {$this->titulo} do álbum {$this->album} de {$this->artista}  |  \n";
    }
}

class Podcast extends Audio
{
    public string $host;

    public function __construct(string $titulo, int $duracao, string $host)
    {
        parent::__construct($titulo, $duracao);
        $this->host = $host;
    }

    public function play(): void
    {
        echo "Escutando episódio {$this->titulo} de {$this->host}\n";
    }
}

$musica = new Musica("Sertanejo Raiz", 240, "Zezé Di Camargo", "As Melhores");
$musica->play();

$podcast = new Podcast("IA no dia-a-dia", 3600, "João Silva");
$podcast->play();

?>
