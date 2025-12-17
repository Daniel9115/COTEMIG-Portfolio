# Projeto MusicLaravelCRUD — N:1

Este projeto é um CRUD de músicas e álbuns em Laravel, com foco em boas práticas de modelagem, relacionamento e cobertura de testes automatizados. O objetivo é garantir que as operações de criação, leitura, atualização e exclusão estejam corretas, bem como a implementação adequada de relacionamentos entre as entidades.

## Objetivo≈

Praticar o desenvolvimento de rotas, controladores, migrations e relacionamentos no Laravel, garantindo que todas as funcionalidades estejam cobertas por testes automatizados.

## Antes de começar

Execute `composer install` para instalar as dependências do projeto, e `php artisan migrate --seed` para criar e popular as tabelas.

## Rúbricas dos Requisitos

### 1. Migration da tabela albums
- Crie uma migration para a tabela `albums` contendo as colunas: `id`, `name`, `year`, `url_img`, `created_at`, `updated_at`.
- Certifique-se de que a migration está registrada e pode ser migrada normalmente.
- O teste automatizado valida a existência da tabela e das colunas.

### 2. Migration da tabela musics com relação a albums
- Adicione a coluna `album_id` na migration de `musics`.
- Implemente a constraint de chave estrangeira relacionando `album_id` com a tabela `albums`.
- O teste automatizado verifica a existência da coluna e da relação.

### 3. Relacionamento N:1 entre Album e Music
- Implemente o relacionamento nas models:
	- `Album` deve ter o método `musics()` (hasMany).
	- `Music` deve ter o método `album()` (belongsTo).
- O teste automatizado verifica se o relacionamento está funcional.

### 4. Listagem de músicas exibindo o nome do álbum
- Na rota `/musics`, cada música listada deve exibir o nome e imagem do álbum correspondentes.
- O teste automatizado verifica se o nome e imagem do álbum aparecem na listagem.

### 5. Exibição de detalhes de um álbum juntamente com suas músicas `GET /albums/{album}`
- Crie uma `AlbumController`, em seu método `show` , exiba todas as músicas pertencentes ao álbum selecionado, registre o método `show` na rota correspondete.
- Dica: use uma view que receba música e use o relacionamento com a Model de Album, para acessar as as músicas.
- O teste automatizado valida se as músicas do álbum são exibidas corretamente.

## Como executar os testes

Execute os testes automatizados para garantir que sua implementação está correta:

```bash
php artisan test --filter=AlbumMusicTest
```

Todos os testes devem passar para que sua solução seja considerada válida.

## Dicas
- Utilize factories para criar instâncias de `Album` e `Music` nos testes e seeders.
- Siga o padrão RESTful para rotas e controllers.
- Consulte os testes em `tests/Feature/AlbumMusicTest.php` para entender o comportamento esperado.
- Use migrations para garantir a estrutura correta do banco de dados.
- Implemente os relacionamentos Eloquent conforme a documentação oficial do Laravel.

Bons estudos e boa implementação!

