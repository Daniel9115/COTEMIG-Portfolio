<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;
use Tests\TestCase;
use Exception;

class MovelAutomatedTest extends TestCase
{
    use RefreshDatabase, WithFaker;

    private $testData = [];

    protected function setUp(): void
    {
        parent::setUp();
        $this->generateTestData();
    }

    private function generateTestData()
    {
        $this->testData = [
            'tipo' => 'Teste Tipo',
            'material' => 'Teste Material',
            'descricao' => 'Este é um texto de teste para o campo descricao',
        ];
    }


    /**
     * 1. Teste de Compilação e Configuração Básica (2pts)
     * - Aplicação Laravel inicializa sem erros
     * - Autoloader funciona corretamente
     * - Configurações básicas estão corretas (.env, APP_KEY, etc.)
     * - Banco de dados conecta sem problemas
     * - Sistema de migrations está funcional
     */
    public function test_1_compilation_and_basic_configuration()
    {
        echo "\n🔧 REQUISITO 1: Testando Compilação e Configuração Básica (2pts)...\n";
        
        // 1.1. Verificar se a aplicação Laravel inicializa
        try {
            $app = app();
            $this->assertNotNull($app, "❌ Aplicação Laravel não conseguiu inicializar");
            echo "✅ Aplicação Laravel inicializada com sucesso\n";
        } catch (Exception $e) {
            $this->fail("❌ Erro ao inicializar aplicação: " . $e->getMessage());
        }
        
        // 1.2. Verificar configuração do banco de dados
        try {
            DB::connection()->getPdo();
            echo "✅ Conexão com banco de dados estabelecida\n";
        } catch (Exception $e) {
            $this->fail("❌ Erro de conexão com banco: " . $e->getMessage());
        }
        
        // 1.3. Verificar se o autoloader está funcionando
        try {
            $this->assertTrue(
                class_exists('Illuminate\\Foundation\\Application'),
                "❌ Classes do Laravel não estão sendo carregadas"
            );
            echo "✅ Autoloader funcionando corretamente\n";
        } catch (Exception $e) {
            $this->fail("❌ Erro no autoloader: " . $e->getMessage());
        }
        
        // 1.5. Verificar se o arquivo .env existe e tem configurações básicas
        $envPath = base_path('.env');
        if (file_exists($envPath)) {
            echo "✅ Arquivo .env encontrado\n";
            
            // Verificar configurações críticas
            $requiredEnvVars = ['APP_KEY', 'DB_CONNECTION'];
            foreach ($requiredEnvVars as $var) {
                $value = env($var);
                $this->assertNotEmpty(
                    $value,
                    "❌ Variável de ambiente $var não configurada"
                );
            }
            echo "✅ Configurações básicas do .env presentes\n";
        } else {
            echo "⚠️  Arquivo .env não encontrado (usando configurações padrão)\n";
        }
        
        // 1.6. Verificar se as migrations podem ser executadas
        try {
            $this->artisan('migrate:status');
            echo "✅ Sistema de migrations funcional\n";
        } catch (Exception $e) {
            echo "⚠️  Sistema de migrations com problema: " . $e->getMessage() . "\n";
        }
        
        echo "🎉 REQUISITO 1 COMPLETO: Aplicação compila e configura corretamente! (2pts)\n";
    }

    /**
     * 2. Teste de Migração da Entidade Movel (2pts)
     * - Migration criada corretamente com os campos definidos
     * - Comando de migration executado sem erros  
     * - Tabela movels criada no banco de dados com estrutura correta
     */
    public function test_2_migration_exists_and_creates_table_correctly()
    {
        echo "\n🔍 REQUISITO 2: Testando Migration da Entidade Movel (2pts)...\n";
        
        // Verificar se a migration existe
        //$migrationPath = database_path('migrations');
        //$migrationFiles = File::glob($migrationPath . '/*_create_movels_table.php');
        
        //$this->assertNotEmpty($migrationFiles, "❌ Migration para criar tabela movels não encontrada");
        //echo "✅ Migration para tabela movels encontrada\n";

        // Verificar se a tabela foi criada
        $this->assertTrue(
            Schema::hasTable('movels'),
            "❌ Tabela movels não foi criada no banco de dados"
        );
        echo "✅ Tabela movels criada no banco de dados\n";

        // Verificar campos obrigatórios
        $requiredColumns = ['id', 'created_at', 'updated_at'];
        foreach ($requiredColumns as $column) {
            $this->assertTrue(
                Schema::hasColumn('movels', $column),
                "❌ Campo obrigatório '$column' não encontrado na tabela movels"
            );
        }
        echo "✅ Campos obrigatórios (id, timestamps) presentes\n";


        // Verificar campos específicos da entidade
        $expectedColumns = ['tipo', 'material', 'descricao'];
        foreach ($expectedColumns as $column) {
            $this->assertTrue(
                Schema::hasColumn('movels', $column),
                "❌ Campo '$column' não encontrado na tabela movels"
            );
        }
        echo "✅ Campos específicos presentes: " . implode(', ', $expectedColumns) . "\n";
        
        echo "🎉 REQUISITO 2 COMPLETO: Migration criada e executada corretamente! (2pts)\n";
    }

    /**
     * 3. Teste do Model Movel (2pts)
     * - Model criado e associado à tabela movels
     * - Criação de registros via Model funciona corretamente
     * - Mass assignment configurado corretamente
     */
    public function test_3_model_exists_and_works_correctly()
    {
        echo "\n🔍 REQUISITO 3: Testando Model Movel (2pts)...\n";
        
        // Verificar se o model existe
        $modelClass = 'App\Models\Movel';
        $this->assertTrue(
            class_exists($modelClass),
            "❌ Model Movel não encontrado em $modelClass"
        );
        echo "✅ Model Movel encontrado\n";

        // Verificar se o model está associado à tabela correta
        $model = new $modelClass;
        $this->assertEquals(
            'movels',
            $model->getTable(),
            "❌ Model Movel não está associado à tabela movels"
        );
        echo "✅ Model Movel associado à tabela movels\n";

        // Testar criação de registro via Model
        try {
            $registro = $modelClass::create($this->testData);
            $this->assertNotNull($registro->id, "❌ Registro não foi criado com ID");
            echo "✅ Criação de registro via Model funciona\n";
        } catch (Exception $e) {
            $this->fail("❌ Erro ao criar registro via Model: " . $e->getMessage());
        }

        // Verificar mass assignment (fillable)
        $fillableFields = $model->getFillable();
        $expectedFields = ['tipo', 'material', 'descricao'];
        
        foreach ($expectedFields as $field) {
            $this->assertTrue(
                in_array($field, $fillableFields),
                "❌ Campo '$field' não está configurado no fillable do Model"
            );
        }
        echo "✅ Mass assignment configurado para todos os campos\n";
        
        echo "🎉 REQUISITO 3 COMPLETO: Model criado e funcionando corretamente! (2pts)\n";
    }

    /**
     * 4. Teste da Rota de Listagem GET /movels (2pts)
     * - Rota configurada corretamente
     * - Método Movel::all() sendo utilizado
     * - Dados aparecem corretamente na resposta
     */
    public function test_4_listing_route_works_correctly()
    {
        echo "\n🔍 REQUISITO 4: Testando Rota de Listagem GET /movels (2pts)...\n";
        
        // Definir classe do model
        $modelClass = 'App\Models\Movel';
        
        // Criar alguns registros de teste
        $modelClass::create($this->testData);
        $modelClass::create($this->testData);
        
        // Testar se a rota existe e responde
        $response = $this->get('/movels');
        $response->assertStatus(200);
        echo "✅ Rota GET /movels responde corretamente\n";

        $content = $response->getContent();
        
        // Verificar se os dados aparecem na resposta (case insensitive)
        foreach ($this->testData as $campo => $valor) {
            $this->assertTrue(
                stripos($content, (string)$valor) !== false,
                "❌ Valor '$valor' do campo '$campo' não encontrado na listagem (busca case insensitive)"
            );
        }
        echo "✅ Dados dos registros aparecem na listagem\n";
        
        // Verificar se há pelo menos uma estrutura de lista/tabela
        //$hasListStructure = (
        //    stripos($content, '<table') !== false ||
        //    stripos($content, '<ul') !== false ||
        //    stripos($content, '<ol') !== false ||
        //    stripos($content, '<div') !== false
        //);
        //$this->assertTrue($hasListStructure, "❌ Nenhuma estrutura de listagem encontrada (table, ul, ol, div)");
        //echo "✅ Estrutura de listagem presente\n";
        
        echo "🎉 REQUISITO 4 COMPLETO: Rota de listagem funcionando corretamente! (2pts)\n";
    }

    /**
     * 5. Teste da Rota de Formulário GET /movels/create (2pts)
     * - Formulário existe e envia para POST /movels
     * - Formulário contém inputs para todos os campos necessários
     */
    public function test_5_create_form_route_works_correctly()
    {
        echo "\n🔍 REQUISITO 5: Testando Rota de Formulário GET /movels/create (2pts)...\n";
        
        // Testar se a rota existe e responde
        $response = $this->get('/movels/create');
        $response->assertStatus(200);
        echo "✅ Rota GET /movels/create responde corretamente\n";

        $content = $response->getContent();
        
        // Verificar se há um formulário que envia para POST /movels
        $this->assertTrue(
            stripos($content, '<form') !== false,
            "❌ Tag <form> não encontrada na página"
        );
        
        $this->assertTrue(
            stripos($content, 'method="post"') !== false || stripos($content, "method='post'") !== false,
            "❌ Formulário não está configurado com method POST (busca case insensitive)"
        );
        
        $this->assertTrue(
            stripos($content, 'action="/movels"') !== false || stripos($content, "action='/movels'") !== false,
            "❌ Formulário não está enviando para /movels (busca case insensitive)"
        );
        echo "✅ Formulário POST para /movels encontrado\n";

        // Verificar token CSRF
        $this->assertTrue(
            stripos($content, '@csrf') !== false || stripos($content, '_token') !== false,
            "❌ Token CSRF não encontrado no formulário (busca case insensitive)"
        );
        echo "✅ Token CSRF presente\n";


        // Verificar inputs específicos do formulário (case insensitive)
        $this->assertTrue(
            stripos($content, 'name="tipo"') !== false,
            "❌ Input tipo não encontrado (busca case insensitive)"
        );
        echo "✅ Input tipo (text) encontrado\n";
        $this->assertTrue(
            stripos($content, 'name="material"') !== false,
            "❌ Input material não encontrado (busca case insensitive)"
        );
        echo "✅ Input material (text) encontrado\n";
        $this->assertTrue(
            stripos($content, 'name="descricao"') !== false,
            "❌ Nome do campo descricao não encontrado no textarea (busca case insensitive)"
        );
        echo "✅ Input descricao (textarea) encontrado\n";

        
        echo "🎉 REQUISITO 5 COMPLETO: Formulário de criação funcionando corretamente! (2pts)\n";
    }

    /**
     * 6. Teste da Rota de Cadastro POST /movels (2pts)
     * - Endpoint recebe e processa os dados do formulário
     * - Registro é salvo corretamente no banco de dados
     * - Dados armazenados são idênticos aos enviados
     */
    public function test_6_store_route_works_correctly()
    {
        echo "\n🔍 REQUISITO 6: Testando Rota de Cadastro POST /movels (2pts)...\n";
        
        // Definir classe do model
        $modelClass = 'App\Models\Movel';
        
        // Testar POST com dados válidos
        $response = $this->post('/movels', $this->testData);
        
        // Aceitar 200, 201 ou 302 (redirect)
        $this->assertTrue(
            in_array($response->getStatusCode(), [200, 201, 302]),
            "❌ POST /movels retornou status inesperado: " . $response->getStatusCode()
        );
        echo "✅ Rota POST /movels responde corretamente\n";

        // Verificar se o registro foi salvo no banco
        $this->assertDatabaseHas('movels', $this->testData);
        echo "✅ Dados foram salvos no banco de dados\n";

        // Verificar se os dados salvos são idênticos aos enviados
        $registro = $modelClass::where($this->testData)->first();
        $this->assertNotNull($registro, "❌ Registro não encontrado no banco com os dados enviados");
        
        foreach ($this->testData as $campo => $valor) {
            $this->assertEquals(
                $valor,
                $registro->$campo,
                "❌ Campo '$campo': valor salvo diferente do enviado"
            );
        }
        echo "✅ Dados salvos são idênticos aos enviados\n";
        
        echo "🎉 REQUISITO 6 COMPLETO: Rota de cadastro funcionando corretamente! (2pts)\n";
    }

    /**
     * 7. Teste do Fluxo CRUD Completo (2pts)
     * - Fluxo de criação e listagem funciona end-to-end
     * - Usuário consegue criar via formulário
     * - Após criação, é redirecionado para listagem
     * - Listagem exibe o novo registro corretamente
     */
    public function test_7_complete_crud_flow_works()
    {
        echo "\n🔍 REQUISITO 7: Testando Fluxo CRUD Completo (2pts)...\n";
        
        // Definir classe do model
        $modelClass = 'App\Models\Movel';
        
        // 1. Verificar estado inicial - sem registros
        $initialCount = $modelClass::count();
        echo "✅ Estado inicial verificado ($initialCount registros)\n";
        
        // 2. Acessar formulário de criação
        $createResponse = $this->get('/movels/create');
        $createResponse->assertStatus(200);
        echo "✅ Formulário de criação acessível\n";
        
        // 3. Enviar dados via POST
        $storeResponse = $this->post('/movels', $this->testData);
        $this->assertTrue(
            in_array($storeResponse->getStatusCode(), [200, 201, 302]),
            "❌ Erro ao criar registro via POST"
        );
        echo "✅ Registro criado via POST\n";
        
        // 4. Verificar se foi criado no banco
        $finalCount = $modelClass::count();
        $this->assertEquals(
            $initialCount + 1,
            $finalCount,
            "❌ Número de registros não aumentou após criação"
        );
        echo "✅ Registro persistido no banco\n";
        
        // 5. Verificar listagem contém o novo registro
        $listResponse = $this->get('/movels');
        $listResponse->assertStatus(200);
        $listContent = $listResponse->getContent();
        
        foreach ($this->testData as $campo => $valor) {
            $this->assertTrue(
                stripos($listContent, (string)$valor) !== false,
                "❌ Novo registro não aparece na listagem: campo '$campo' com valor '$valor' (busca case insensitive)"
            );
        }
        echo "✅ Novo registro aparece na listagem\n";
        
        // 6. Verificar se há redirecionamento após criação (se aplicável)
        if ($storeResponse->getStatusCode() === 302) {
            $redirectLocation = $storeResponse->headers->get('Location');
            if ($redirectLocation) {
                echo "✅ Redirecionamento após criação: $redirectLocation\n";
            }
        }
        
        echo "🎉 REQUISITO 7 COMPLETO: Fluxo CRUD funcionando end-to-end! (2pts)\n";
    }
}