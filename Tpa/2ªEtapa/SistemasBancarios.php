<!-- Questão 1 -->

<?php
class ContaBancaria
{
    private $numeroConta;
    private $saldo;
    const TAXA_TRANSFERENCIA = 2.50;

    public function __construct($numeroConta, $saldoInicial)
    {
        $this->numeroConta = $numeroConta;
        $this->saldo = $saldoInicial;
    }

    public function depositar($valor)
    {
        if ($valor < 0) {
            throw new Exception("Valor de depósito inválido.");
        }
        $this->saldo += $valor;
    }

    public function sacar($valor)
    {
        if ($valor > $this->saldo) {
            return false; // Saldo insuficiente
        }
        $this->saldo -= $valor;
        return true;
    }
    public function extrato()
    {
        return "Conta: {$this->numeroConta}, Saldo: R$ {$this->saldo}";
    }

    public function transferir($valor, $contaDestino)
    {
        if ($valor + self::TAXA_TRANSFERENCIA > $this->saldo) {
            return false; // Saldo insuficiente
        }
        $this->sacar($valor + self::TAXA_TRANSFERENCIA);
        $contaDestino->depositar($valor);
        return true;
    }
}

// Teste Automatizado
$contaJoao = new ContaBancaria("C1123", 1000);
var_dump($contaJoao->extrato());
$contaMaria = new ContaBancaria("D1456", 500);
$contaJoao->transferir(300, $contaMaria);
var_dump($contaMaria->extrato());
// Teste de saque com saldo insuficiente
$contaJoao->sacar(800);
// Teste de transferência com valor zero
$contaJoao->transferir(0, $contaMaria); 
var_dump($contaJoao->extrato()); 
var_dump($contaMaria->extrato()); 
?>