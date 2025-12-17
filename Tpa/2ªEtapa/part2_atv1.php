<?php
require_once 'PaginaItemCardapio.php';
class PaginaBebida extends PaginaItemCardapio
{
    public int $volume;

    public function __construct(string $nome, float $preco, int $volume)
    {
        parent::__construct($nome, $preco);
        $this->volume = $volume;
    }

    function criarEspecificacoes(): string
    {
        return "<p>Volume: {$this->volume}ml</p>";
    }
}