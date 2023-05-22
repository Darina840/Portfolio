using BlazorApp1.Data.Models;

namespace BlazorApp1.Services
{
    public interface IProductProvider
    {
        Task<List<Product>?> GetAll();
        Task<Product?> GetOne(int id);
        Task<bool> Add(Product item);
        Task<bool> Edit(Product item);
        Task<bool> Remove(int id);
    }
}
