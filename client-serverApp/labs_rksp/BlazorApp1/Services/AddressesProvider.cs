using System.Net;
using System.Net.Http.Json;
using System.Text.Json.Serialization;
using Newtonsoft.Json;
using BlazorApp1.Data.Models;
using BlazorApp1.Services;

namespace BlazorApp1.Services
{
    public class AddressesProvider : IAddressProvider
    {
        private HttpClient _client;
        public AddressesProvider(HttpClient client)
        {
            _client = client;
        }

        public async Task<List<Address>> GetAll()
        {
            return await _client.GetFromJsonAsync<List<Address>>("/api/address");
        }

        public async Task<Address> GetOne(int id)
        {
            return await _client.GetFromJsonAsync<Address>($"/api/address/{id}");
        }

        public async Task<bool> Add(Address item)
        {
            string data = JsonConvert.SerializeObject(item);
            StringContent httpContent = new StringContent(data, System.Text.Encoding.UTF8, "application/json");
            var responce = await _client.PostAsync($"/api/address", httpContent);
            return await Task.FromResult(responce.IsSuccessStatusCode);
        }

        public async Task<Address> Edit(Address item)
        {
            string data = JsonConvert.SerializeObject(item);
            StringContent httpContent = new StringContent(data, System.Text.Encoding.UTF8, "application/json");
            var responce = await _client.PutAsync($"/api/address", httpContent);
            Address address = JsonConvert.DeserializeObject<Address>(responce.Content.ReadAsStringAsync().Result);
            return await Task.FromResult(address);
        }

        public async Task<bool> Remove(int id)
        {
            var delete = await _client.DeleteAsync($"/api/address/${id}");

            return await Task.FromResult(delete.IsSuccessStatusCode);
        }
    }
}
