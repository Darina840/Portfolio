using System.Net.Http.Json;
using System.Text;
using Newtonsoft.Json;
using BlazorApp1.Data.Models;

namespace BlazorApp1.Services
{
    public class ProductsProvider : IProductProvider
    {
        private readonly HttpClient _client;
        public ProductsProvider(HttpClient client)
        {
            _client = client;
        }

        public async Task<List<Product>?> GetAll()
        {
            return await _client.GetFromJsonAsync<List<Product>>("api/product");
        }

        public async Task<Product?> GetOne(int id)
        {
            return await _client.GetFromJsonAsync<Product>($"api/product/{id}");
        }

        public async Task<bool> Add(Product item)
        {
            string data = JsonConvert.SerializeObject(item);
            var httpContent = new StringContent(data, Encoding.UTF8, "application/json");
            var response = await _client.PostAsync("api/product", httpContent);
            return await Task.FromResult(response.IsSuccessStatusCode);
        }

        public async Task<bool> Edit(Product item)
        {
            string data = JsonConvert.SerializeObject(item);

            var httpContent = new StringContent(data, Encoding.UTF8, "application/json");
            var response = await _client.PutAsync($"api/product/{item.Id}", httpContent);
            return await Task.FromResult(response.IsSuccessStatusCode);
        }

        public async Task<bool> Remove(int id)
        {
            var delete = await _client.DeleteAsync($"/api/product/{id}");

            return await Task.FromResult(delete.IsSuccessStatusCode);
        }
    }
}
