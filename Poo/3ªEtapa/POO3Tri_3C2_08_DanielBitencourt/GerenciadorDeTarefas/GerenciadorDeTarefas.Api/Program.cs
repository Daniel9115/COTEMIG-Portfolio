using GerenciadorDeTarefas.Components;
using GerenciadorDeTarefas.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Identity;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// Configuração do ASP.NET Core Identity
builder.Services.AddDefaultIdentity<IdentityUser>(options =>
    {
        options.SignIn.RequireConfirmedAccount = false;
        options.Password.RequireDigit = false;
        options.Password.RequiredLength = 6;
        options.Password.RequireNonAlphanumeric = false;
        options.Password.RequireUppercase = false;
        options.Password.RequireLowercase = false;
    })
    .AddEntityFrameworkStores<ApplicationDbContext>();

builder.Services.AddCascadingAuthenticationState();
builder.Services.AddAuthorization();

builder.Services.AddControllers();

builder.Services.AddScoped(sp => 
{
    var httpContext = sp.GetRequiredService<IHttpContextAccessor>().HttpContext;
    var client = new HttpClient();
    if (httpContext != null)
    {
        client.BaseAddress = new Uri($"{httpContext.Request.Scheme}://{httpContext.Request.Host}");
    }
    return client;
});

builder.Services.AddHttpContextAccessor();

// Adiciona o CORS para permitir requisições do Blazor Client
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowBlazorClient",
        builder => builder.AllowAnyOrigin() // Em produção, use WithOrigins("https://localhost:7000")
                          .AllowAnyMethod()
                          .AllowAnyHeader());
});

builder.Services.AddRazorPages();

builder.Services.AddRazorComponents()
    .AddInteractiveServerComponents()
    .AddInteractiveWebAssemblyComponents();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseWebAssemblyDebugging();
}
else
{
    app.UseExceptionHandler("/Error", createScopeForErrors: true);
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseAntiforgery();

// Habilita o CORS
app.UseCors("AllowBlazorClient");

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.MapRazorComponents<App>()
    .AddInteractiveServerRenderMode()
    .AddInteractiveWebAssemblyRenderMode();

app.MapRazorPages();

// Criação do usuário administrador
using (var scope = app.Services.CreateScope())
{
    var userManager = scope.ServiceProvider.GetRequiredService<UserManager<IdentityUser>>();
    if (userManager.FindByNameAsync("admin@gerenciador.com").Result == null)
    {
        var adminUser = new IdentityUser { UserName = "admin@gerenciador.com", Email = "admin@gerenciador.com", EmailConfirmed = true };
        var result = userManager.CreateAsync(adminUser, "Admin@123").Result;
    }
}

app.Run();
