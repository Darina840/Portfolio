using labs_rksp.Data.DTOs;
using Microsoft.EntityFrameworkCore;
using labs_rksp.Data.Models;

namespace labs_rksp.Data.Services
{
    public class ProductService
    {
        private EducationContext _context;
        public ProductService(EducationContext context)
        {
            _context = context;
        }
        public async Task<Product?> AddProduct(ProductDTO product)
        {
            Product nproduct = new Product
            {
                Id = product.Id,
                Name = product.Name,
                Price = product.Price,
                Material = product.Material,
            };
            if (product.Orders.Any())
                nproduct.Orders = _context.Orders.ToList().IntersectBy(product.Orders, product => product.Id).ToList();

            var result = _context.Products.Add(nproduct);
            await _context.SaveChangesAsync();
            return await Task.FromResult(result.Entity);
        }

        public async Task<Product?> GetProduct(int id)
        {
            var result = _context.Products.Include(s => s.Orders).FirstOrDefault(p => p.Id == id);
            return await Task.FromResult(result);
        }

        public async Task<List<Product>> GetProducts()
        {
            var result = await _context.Products.Include(s => s.Orders).ToListAsync();
            return await Task.FromResult(result);
        }

        public async Task<Product?> UpdateProduct(int id, Product newProduct)
        {
            var product = await _context.Products.Include(o => o.Orders).FirstOrDefaultAsync(s => s.Id == id);
            if (product != null)
            {
                product.Id = newProduct.Id;
                product.Name = newProduct.Name;
                product.Price = newProduct.Price;
                product.Material = newProduct.Material;
                if (newProduct.Orders.Any())
                    product.Orders = _context.Orders.ToList().IntersectBy(newProduct.Orders, o => o).ToList();

                _context.Products.Update(product);
                _context.Entry(product).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return product;
            }

            return null;

        }

        public async Task<bool> DeleteProduct(int id)
        {
            var product = await _context.Products.FirstOrDefaultAsync(s => s.Id == id);
            if (product != null)
            {
                _context.Products.Remove(product);
                await _context.SaveChangesAsync();
                return true;
            }

            return false;
        }
    }
}
