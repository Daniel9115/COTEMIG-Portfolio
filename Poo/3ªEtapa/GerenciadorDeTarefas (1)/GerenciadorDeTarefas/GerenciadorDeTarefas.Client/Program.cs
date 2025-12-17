using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using Blazored.Toast;

var builder = WebAssemblyHostBuilder.CreateDefault(args);

builder.Services.AddBlazoredToast();

await builder.Build().RunAsync();
