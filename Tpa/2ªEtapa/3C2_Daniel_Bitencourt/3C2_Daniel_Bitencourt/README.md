

Prova final - 2ª Etapa - TPA
# Projeto Laravel - Movel

## Instruções
Baixe o projeto Laravel base anexado na atividade do Classroom, ela vai aparecer no seu H, mas não deszipe ela lá.

Mova a pasta para Documents e descompacte ela só nesse momento, depois renomeie a pasta para `3XX_Seu_Nome`, sendo 3XX sua turma e seu nome separado por _

### Entrega 
Deve ser feita pelo Google Classroom, anexando o projeto completo em formato ZIP.


Esta prova tem como objetivo avaliar sua capacidade de criar uma aplicação Laravel incluindo a configuração inicial, migrações, models, controllers, views e rotas.

A aplicação deve permitir cadastrar, listar e gerenciar movels com os campos: tipo, material, descricao.

Siga os critérios de avaliação abaixo, seguindo a risca os nomes propostos, tanto em questão de singular e plural, quanto em relação as letras maiúsculas e minusculas.

Rubrica de Avaliação:

1. Compilação e Configuração Básica (2pts)
- Aplicação Laravel inicializa sem erros
- É possível rodar os testes sem erros
- Banco de dados conecta sem problemas
- Sistema de migrations está funcional

2. Migração da Entidade **Movel** (2pts)
- Migration criada corretamente com os campos: id, tipo (string), material (string), descricao (text) e timestamps (created_at, updated_at)
- Comando de migration executado sem erros
- Tabela **movels** criada no banco de dados com estrutura correta

3. Model **Movel** (2pts)
- Model criado e associado à tabela **movels**
- Criação de registros via Model funciona corretamente
- Atributo fillable configurado para os campos tipo, material, descricao

4. Rota de Listagem **GET /movels** (2pts)
- Rota configurada corretamente retornando view 
- Método Movel::all() sendo utilizado na rota
- Dados aparecem corretamente na resposta (testar com 2-3 registros)

5. Rota de Formulário **GET /movels/create** (2pts)
- Formulário existe e envia para **POST /movels**
- Formulário contém inputs com atributos `name` para: tipo (text), material (text), descricao (textarea)

6. Rota de Cadastro **POST /movels** (2pts)
- Endpoint recebe e processa os dados do formulário
- Registro é salvo corretamente no banco de dados
- Dados armazenados são idênticos aos enviados no formulário

7. Fluxo de Criação e Listagem funcional (2pts)
- Usuário consegue criar um(a) novo(a) Movel via formulário
- Após criação, usuário é redirecionado para a listagem de movels
- Listagem exibe o novo(a) Movel corretamente

Total: 14 pontos

