using BlazorApp1;
using BlazorApp1.Services;
using Microsoft.AspNetCore.Components.Web;
using Microsoft.AspNetCore.Components.WebAssembly.Hosting;
using IServiceProvider = System.IServiceProvider;

var builder = WebAssemblyHostBuilder.CreateDefault(args);
builder.RootComponents.Add<App>("#app");
builder.RootComponents.Add<HeadOutlet>("head::after");

var baseApiUri = builder.Configuration.GetValue<string>("BaseApiUri");

builder.Services.AddScoped(sp => new HttpClient
{
    BaseAddress = new Uri(baseApiUri)
});

builder.Services.AddScoped<IProductProvider, ProductsProvider>();
builder.Services.AddScoped<IAddressProvider, AddressesProvider>();
builder.Services.AddScoped<ISProvider, ServicesProvider>();
await builder.Build().RunAsync();
