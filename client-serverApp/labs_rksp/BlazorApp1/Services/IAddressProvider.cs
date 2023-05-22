using BlazorApp1.Data.Models;

namespace BlazorApp1.Services
{
    public interface IAddressProvider
    {
        Task<List<Address>> GetAll();
        Task<Address> GetOne(int id);
        Task<bool> Add(Address item);
        Task<Address> Edit(Address item);
        Task<bool> Remove(int id);
    }
}
