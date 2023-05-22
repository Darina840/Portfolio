using labs_rksp.Data.DTOs;
using Microsoft.EntityFrameworkCore;
using labs_rksp.Data.Models;

namespace labs_rksp.Data.Services
{
    public class OrderService
    {
        private EducationContext _context;
        public OrderService(EducationContext context)
        {
            _context = context;
        }

        public async Task<OrderDTO?> AddOrder(OrderDTO orderDTO)
        {

            Order order = new Order()
            {
                Id = orderDTO.Id,
                Date = orderDTO.Date,
                Amount = orderDTO.Amount,
                Cost = orderDTO.Cost,
                
            };

            var result = _context.Orders.Add(order);
            await _context.SaveChangesAsync();

            return await Task.FromResult(orderDTO);
        }

        public async Task<OrderDTO?> GetOrder(int id)
        {
            var order = await _context.Orders.FirstOrDefaultAsync(order => order.Id == id);
            if (order == null) return null;

            var orderDTO = new OrderDTO()
            {
                Id = order.Id,
                Date = order.Date,
                Amount = order.Amount,
                Cost = order.Cost,
                
            };

            return orderDTO;
        }

        public async Task<List<OrderDTO>> GetOrders()
        {
            return await _context.Orders
                .Select(order => new OrderDTO()
                {
                   Id = order.Id,
                    Date = order.Date,
                    Amount = order.Amount,
                    Cost = order.Cost,
                    
                })
                .ToListAsync();
        }

        public async Task<List<IncompleteOrderDTO>> GetOrdersIncomplete()
        {
            var orders = await _context.Orders.ToListAsync();
            List<IncompleteOrderDTO> result = new List<IncompleteOrderDTO>();
            orders.ForEach(pr => result.Add(new IncompleteOrderDTO { Date = pr.Date, Cost = pr.Cost, Amount = pr.Amount }));
            return await Task.FromResult(result);
        }

        public async Task<OrderDTO?> UpdateOrder(int id, OrderDTO orderDTO)
        {
            var order = await _context.Orders.FirstOrDefaultAsync(pr => pr.Id == id);
            
            if (order == null)
                return null;

            order.Id = orderDTO.Id;
            order.Date = orderDTO.Date;
            order.Cost = orderDTO.Cost;
            order.Amount = orderDTO.Amount;
            _context.Orders.Update(order);
            _context.Entry(order).State = EntityState.Modified;
            
            return await Task.FromResult(orderDTO);

        }

        public async Task<bool> DeleteOrder(int id)
        {
            var order = await _context.Orders.FirstOrDefaultAsync(pr => pr.Id == id);
            if (order != null)
            {
                _context.Orders.Remove(order);
                await _context.SaveChangesAsync();
                return true;
            }

            return false;
        }
    }
}
