<?php

require_once "PaginaItemCardapio.php";
class PaginaComida extends PaginaItemCardapio
{
    public bool $vegano;

    public function __construct(string $nome, float $preco, bool $vegano)
    {
        //$this->nome = $nome;
        //$this->preco = $preco;
        parent::__construct($nome, $preco);
        $this->vegano = $vegano;
    }

    function criarEspecificacoes(): string
    {
        $vegano = $this->vegano ? "Sim" : "Não";
        return "<p>Vegano: {$vegano}</p>";
    }
}

$pagina = new PaginaComida("Karê", 13, true);
$pagina->exibirDados();
