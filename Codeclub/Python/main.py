
import os
os.system('cls')
n1 = int(input("Número 1: "))
n2 = int(input("Número 2: "))

if n1 > n2:
    print(n1, " é maior que ", n2)
else:
    print(n2, " é maior que ", n1)

soma = n1 + n2
subtracao = n1 - n2
multiplicacao = n1 * n2

print(f"Soma: {soma}\nSubtração: {subtracao}\nMultiplicação: {multiplicacao}")

if(n1 == 0 or n2 == 0):
    print("Não é possível fazer divisão por 0")
else:
    divisao = n1/n2
    print("Divisão: ", divisao)


 