<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Tests\TestCase;

class EvalTest extends TestCase
{
    // Use RefreshDatabase para garantir que o banco de dados seja redefinido
    // para cada teste. Isso evita que os testes interfiram uns nos outros.
    use RefreshDatabase;

    /** * Testa se o Controller TaskController existe. */ public function test_task_controller_exists()
    {
        $controllerPath = app_path('Http/Controllers/TaskController.php');

        if (!file_exists($controllerPath)) {
            $this->fail('TaskController file does not exist at: ' . $controllerPath . "\nPlease create the file first.");
        }

        // Se o arquivo existe, verifica se a classe existe
        $this->assertTrue(class_exists('App\Http\Controllers\TaskController'), 'TaskController class does not exist in the file');
    }

    /** * Testa se o Model Task existe. */ public function test_task_model_exists()
    {
        $modelPath = app_path('Models/Task.php');

        if (!file_exists($modelPath)) {
            $this->fail('Task model file does not exist at: ' . $modelPath . "\nPlease create the file first.");
        }

        // Se o arquivo existe, verifica se a classe existe
        $this->assertTrue(class_exists('App\Models\Task'), 'Task model class does not exist in the file');
    }

    /** * Testa se a página de listagem de tarefas (index) pode ser acessada. */ public function test_tasks_index_page_can_be_rendered()
    {
        // Primeiro verifica se os arquivos necessários existem
        if (!class_exists('App\Http\Controllers\TaskController')) {
            $this->markTestSkipped('TaskController does not exist');
        }

        // Envia uma requisição GET para a rota 'tasks.index'
        $response = $this->get('/tasks');

        // Verifica se a resposta HTTP é 200 (OK)
        $response->assertStatus(200);

        // Verifica se a view 'tasks.index' foi retornada
        $response->assertViewIs('tasks.index');
    }

    /** * Testa se a página de criação de tarefas (create) pode ser acessada. */ public function test_tasks_create_page_can_be_rendered()
    {
        // Primeiro verifica se os arquivos necessários existem
        if (!class_exists('App\Http\Controllers\TaskController')) {
            $this->markTestSkipped('TaskController does not exist');
        }

        // Envia uma requisição GET para a rota 'tasks.create'
        $response = $this->get('/tasks/create');

        // Verifica se a resposta HTTP é 200 (OK)
        $response->assertStatus(200);

        // Verifica se a view 'tasks.create' foi retornada
        $response->assertViewIs('tasks.create');
    }

    /** * Testa se uma nova tarefa pode ser criada e salva no banco de dados. * Simula o envio de um formulário e verifica o resultado no banco. */ public function test_a_new_task_is_stored_in_the_database()
    {
        // Primeiro verifica se os arquivos necessários existem
        if (!class_exists('App\Http\Controllers\TaskController') || !class_exists('App\Models\Task')) {
            $this->markTestSkipped('TaskController or Task model does not exist');
        }

        // Simula os dados de uma nova tarefa
        $taskData = [
            'title' => 'Nova Tarefa de Teste',
            'description' => 'Descrição da nova tarefa.',
            'status' => 'pendente'
        ];

        // Envia uma requisição POST para a rota 'tasks.store' com os dados
        $response = $this->post('/tasks', $taskData);

        // Verifica se a resposta redireciona para a página de listagem de tarefas
        $response->assertRedirect('/tasks');

        // Verifica se o registro com os dados corretos foi criado no banco de dados
        $this->assertDatabaseHas('tasks', $taskData);
    }

    /** * Testa se a criação de uma tarefa falha sem um título, gerando um erro de validação. */ public function test_task_creation_fails_without_a_title()
    {
        // Primeiro verifica se os arquivos necessários existem
        if (!class_exists('App\Http\Controllers\TaskController') || !class_exists('App\Models\Task')) {
            $this->markTestSkipped('TaskController or Task model does not exist');
        }

        // Simula os dados da tarefa sem o campo 'title'
        $taskData = [
            'description' => 'Esta tarefa não tem título.',
        ];

        // Envia uma requisição POST para 'tasks.store'
        $response = $this->post('/tasks', $taskData);

        // Verifica se a resposta retorna um erro de validação para o campo 'title'
        $response->assertSessionHasErrors('title');

        // Verifica se nenhum registro foi criado no banco de dados
        $this->assertDatabaseMissing('tasks', $taskData);
    }

    /** * Testa se o modelo Task tem os campos fillable definidos corretamente. */ public function test_task_model_has_fillable_attributes()
    {
        // Primeiro verifica se o modelo existe
        if (!class_exists('App\Models\Task')) {
            $this->markTestSkipped('Task model does not exist');
        }

        // Cria uma nova instância do modelo
        $task = new \App\Models\Task();

        // Define os campos que devem ser fillable
        $fillable = ['title', 'description', 'status'];

        // Verifica se os campos fillable do modelo correspondem ao array esperado
        $this->assertEquals($fillable, $task->getFillable());
    }

    /** * Testa se o formulário de criação submete corretamente para POST /tasks */ public function test_create_form_submits_to_tasks_store()
    {
        // Primeiro verifica se os arquivos necessários existem
        if (!class_exists('App\Http\Controllers\TaskController')) {
            $this->markTestSkipped('TaskController does not exist');
        }

        // Verifica se as rotas existem verificando se estão registradas
        $routeCollection = app('router')->getRoutes();
        $hasCreateRoute = false;
        $hasStoreRoute = false;

        foreach ($routeCollection as $route) {
            if ($route->uri() === 'tasks/create' && in_array('GET', $route->methods())) {
                $hasCreateRoute = true;
            }
            if ($route->uri() === 'tasks' && in_array('POST', $route->methods())) {
                $hasStoreRoute = true;
            }
        }

        if (!$hasCreateRoute || !$hasStoreRoute) {
            $this->markTestSkipped('Task routes (GET /tasks/create or POST /tasks) not defined in web.php');
        }

        // Acessa a página de criação
        $response = $this->get('/tasks/create');

        // Se a rota não existir, o teste deve falhar informando isso
        if ($response->getStatusCode() === 404) {
            $this->fail('Route GET /tasks/create not found. Please define the route in web.php');
        }

        $response->assertStatus(200);

        // Verifica se o formulário existe na página
        $response->assertSee('<form', false);
        $response->assertSee('method="POST"', false);

        // Verifica se o formulário aponta para a rota correta
        $response->assertSee('action="/tasks"', false);

        // Verifica se tem o token CSRF
        $response->assertSee('name="_token"', false);

        // Verifica se tem os campos necessários
        $response->assertSee('name="title"', false);
        $response->assertSee('name="description"', false);
        $response->assertSee('name="status"', false);

        // Simula o preenchimento e envio do formulário
        $taskData = [
            'title' => 'Tarefa do Formulário',
            'description' => 'Descrição da tarefa criada via formulário.',
            'status' => 'pendente'
        ];

        // Envia o POST como se fosse do formulário
        $postResponse = $this->post('/tasks', $taskData);

        // Verifica se o POST foi processado corretamente
        // (pode ser redirect ou outra resposta, dependendo da implementação)
        $this->assertTrue(
            in_array($postResponse->getStatusCode(), [200, 201, 302, 404]),
            'POST request should return success status (200, 201, 302) or 404 if route not defined'
        );

        // Se retornou 404, informa que a rota não foi definida
        if ($postResponse->getStatusCode() === 404) {
            $this->fail('Route POST /tasks not found. Please define the route in web.php');
        }

        // Se tiver modelo Task, verifica se foi salvo no banco
        if (class_exists('App\Models\Task')) {
            $this->assertDatabaseHas('tasks', [
                'title' => 'Tarefa do Formulário',
                'description' => 'Descrição da tarefa criada via formulário.',
                'status' => 'pendente'
            ]);
        }
    }
}
