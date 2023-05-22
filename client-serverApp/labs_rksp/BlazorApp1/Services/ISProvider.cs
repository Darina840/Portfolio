using BlazorApp1.Data.Models;

namespace BlazorApp1.Services
{
    public interface ISProvider
    {
        Task<List<Service>> GetAll();
        Task<Service> GetOne(int id);
        Task<bool> Add(Service item);
        Task<Service> Edit(Service item);
        Task<bool> Remove(int id);
    }
}
