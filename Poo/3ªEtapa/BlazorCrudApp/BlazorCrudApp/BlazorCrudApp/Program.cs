using BlazorCrudApp.Components;
using BlazorCrudApp.Data;
using Microsoft.EntityFrameworkCore;

// Cria o construtor da aplicação web.
var builder = WebApplication.CreateBuilder(args);

// Adiciona os serviços necessários para os componentes Blazor.
builder.Services.AddRazorComponents()
    // Habilita a interatividade no lado do servidor (via SignalR).
    .AddInteractiveServerComponents()
    // Habilita a interatividade no lado do cliente (via WebAssembly).
    .AddInteractiveWebAssemblyComponents();

// Registra o ApplicationDbContext no sistema de injeção de dependência.
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    // Configura o EF Core para usar o SQL Server com a string de conexão do appsettings.json.
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Adiciona os serviços para que os Controllers de API funcionem.
builder.Services.AddControllers();

// Constrói a aplicação.
var app = builder.Build();

// Configura o pipeline de requisições HTTP.
// Se estiver em ambiente de desenvolvimento...
if (app.Environment.IsDevelopment())
{
    // Habilita o debugger para WebAssembly.
    app.UseWebAssemblyDebugging();
}
else // Senão (em produção)...
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}

// Adiciona middlewares padrão.
app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseAntiforgery();

// Habilita o roteamento para os Controllers de API.
app.MapControllers();

// Mapeia os componentes Blazor, definindo o componente raiz ''.
app.MapRazorComponents<App>()
    // Adiciona os modos de renderização interativos.
    .AddInteractiveServerRenderMode()
    .AddInteractiveWebAssemblyRenderMode()
    // Informa ao servidor onde encontrar os componentes do projeto cliente.
    .AddAdditionalAssemblies(typeof(BlazorCrudApp.Client._Imports).Assembly);

// Executa a aplicação.
app.Run();
