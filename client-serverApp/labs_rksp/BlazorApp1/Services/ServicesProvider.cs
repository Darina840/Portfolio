using System.Net;
using System.Net.Http.Json;
using System.Text.Json.Serialization;
using Newtonsoft.Json;
using BlazorApp1.Data.Models;
using BlazorApp1.Services;

namespace BlazorApp1.Services
{
    public class ServicesProvider : ISProvider
    {
        private HttpClient _client;
        public ServicesProvider(HttpClient client)
        {
            _client = client;
        }

        public async Task<List<Service>> GetAll()
        {
            return await _client.GetFromJsonAsync<List<Service>>("/api/service");
        }

        public async Task<Service> GetOne(int id)
        {
            return await _client.GetFromJsonAsync<Service>($"/api/service/{id}");
        }

        public async Task<bool> Add(Service item)
        {
            string data = JsonConvert.SerializeObject(item);
            StringContent httpContent = new StringContent(data, System.Text.Encoding.UTF8, "application/json");
            var responce = await _client.PostAsync($"/api/service", httpContent);
            return await Task.FromResult(responce.IsSuccessStatusCode);
        }

        public async Task<Service> Edit(Service item)
        {
            string data = JsonConvert.SerializeObject(item);
            StringContent httpContent = new StringContent(data, System.Text.Encoding.UTF8, "application/json");
            var responce = await _client.PutAsync($"/api/service", httpContent);
            Service service = JsonConvert.DeserializeObject<Service>(responce.Content.ReadAsStringAsync().Result);
            return await Task.FromResult(service);
        }

        public async Task<bool> Remove(int id)
        {
            var delete = await _client.DeleteAsync($"/api/service/${id}");

            return await Task.FromResult(delete.IsSuccessStatusCode);
        }
    }
}
