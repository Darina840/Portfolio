using labs_rksp.Data.DTOs;
using Microsoft.EntityFrameworkCore;
using labs_rksp.Data.Models;

namespace labs_rksp.Data.Services
{
    public class SService
    {
        private EducationContext _context;
        public SService(EducationContext context)
        {
            _context = context;
        }

        public async Task<Service?> AddService(ServiceDTO service)
        {
            Service nservice = new Service
            {
                Name = service.Name,
            };

            var result = _context.Services.Add(nservice);
            await _context.SaveChangesAsync();
            return await Task.FromResult(result.Entity);
        }

        public async Task<Service?> GetService(int id)
        {
            var result = _context.Services.FirstOrDefault(service => service.Id == id);
            return await Task.FromResult(result);
        }

        public async Task<List<Service>> GetServices()
        {
            var result = await _context.Services.ToListAsync();
            return await Task.FromResult(result);
        }

        public async Task<Service?> UpdateService(int id, Service newService)
        {
            var service = await _context.Services.FirstOrDefaultAsync(s => s.Id == id);
            if (service != null)
            {
                service.Name = newService.Name;
                _context.Services.Update(service);
                _context.Entry(service).State = EntityState.Modified;
                await _context.SaveChangesAsync();
                return service;
            }

            return null;
        }

        public async Task<bool> DeleteService(int id)
        {
            var service = await _context.Services.FirstOrDefaultAsync(s => s.Id == id);
            if (service != null)
            {
                _context.Services.Remove(service);
                await _context.SaveChangesAsync();
                return true;
            }

            return false;

        }
    }
}
