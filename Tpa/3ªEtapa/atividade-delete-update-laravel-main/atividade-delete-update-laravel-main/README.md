# Projeto MusicLaravelCRUD

Este projeto é um CRUD (Create, Read, Update, Delete) de músicas desenvolvido em Laravel. Ele permite cadastrar, listar, editar, visualizar e excluir registros de músicas, cada uma com os campos: título, artista, álbum, ano e gênero. O projeto  possui testes automatizados para avaliar suas implementações de edição, atualização e exclusão.

## Objetivo

O objetivo deste exercício é praticar o desenvolvimento de rotas e controladores no Laravel, garantindo que as operações de edição, atualização e exclusão estejam corretas e passem nos testes automatizados fornecidos.

## Antes de começar

Execute `composer install` para instalar as dependências do projeto, e `php artisan migrate --seed` para criar e popular as tabelas.

## Requisitos

Implemente as rotas e métodos necessários para que as operações de editar, atualizar e deletar músicas funcionem corretamente. Para ser aprovado, seu código deve passar nos testes automatizados já presentes no projeto. Siga atentamente as orientações de cada requisito:

### Requisito 1: Rota e método de edição (edit)
- Crie uma rota `GET` para `/musics/{music}/edit` apontando para o método `edit` do controlador.
- Crie método `edit` da MusicController, busque a música pelo parâmetro recebido e retorne a view de edição, enviando o objeto da música para a view.
- Certifique-se de que o formulário de edição seja preenchido automaticamente com os dados atuais da música.
- Os campos do formulário devem ter seu atributo `name` como estão os seguintes: `title` (título), `artist` (artista), `album` (álbum), `year` (ano) e `genre` (gênero).
- Dica: utilize o método `findOrFail` e a função `compact` para enviar dados para a view.
- O teste `test_edit_view_displays_music_data` deve passar se a view exibir corretamente os dados da música selecionada.

### Requisito 2: Rota e método de atualização (update)
- Crie uma rota `PUT` para `/musics/{music}` apontando para o método `update` do controlador.
- No método `update` da MusicController,, valide os dados recebidos do formulário e atualize o registro correspondente no banco de dados.
- Os campos que devem ser atualizados são: `title` (título), `artist` (artista), `album` (álbum), `year` (ano) e `genre` (gênero).
- Após atualizar, redirecione para a listagem de músicas (`music.index`) e exiba uma mensagem de sucesso.
- Dica: utilize o método `update` do Eloquent e a função `redirect()->route()`.
- O teste `test_update_music` deve passar se a atualização for realizada corretamente e o redirecionamento ocorrer.

### Requisito 3: Rota e método de exclusão (delete)
- Crie uma rota `DELETE` para `/musics/{music}` apontando para o método `destroy` do controlador.
- Cire método `destroy` da MusicController, remova o registro da música do banco de dados.
- Após a exclusão, redirecione para a listagem de músicas (`music.index`) e exiba uma mensagem de sucesso.
- Dica: utilize o método `delete` do Eloquent.
- O teste `test_delete_music` deve passar se a exclusão for realizada corretamente e o redirecionamento ocorrer.
No
## Como executar os testes

Para verificar se sua implementação está correta, execute os testes automatizados com o comando abaixo no terminal, na raiz do projeto:

```bash
php artisan test --filter=MusicCrudTest
```

Todos os testes devem passar para que sua solução seja considerada válida.

## Dicas
- Utilize o recurso de rotas nomeadas do Laravel para facilitar os redirecionamentos.
- Siga o padrão RESTful para a implementação das rotas e métodos.
- Consulte os testes em `tests/Feature/MusicCrudTest.php` para entender o comportamento esperado.
- Se quiser uma macete sobre `git`, [clique aqui](https://education.github.com/git-cheat-sheet-education.pdf) e veja uma lista com os comandos mias comuns.
Bons estudos!

