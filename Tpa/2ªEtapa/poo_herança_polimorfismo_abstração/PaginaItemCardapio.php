<?php

abstract class PaginaItemCardapio
{
    public string $nome;
    public float $preco;

    /**
     * @param string $nome
     * @param float $preco
     */
    public function __construct(string $nome, float $preco)
    {
        $this->nome = $nome;
        $this->preco = $preco;
    }

    function exibirDados() :void
    {
        echo "
        <h1>Cardápio</h1>
        <h2>{$this->nome}</h2>
        <p>R$ {$this->preco}</p>
        <div>{$this->criarEspecificacoes()}</div>
        ";
    }

    abstract function criarEspecificacoes(): string;
}