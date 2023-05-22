using labs_rksp.Data.DTOs;
using labs_rksp.Data.Services;
using labs_rksp.Data.Models;
using Microsoft.AspNetCore.Mvc;

namespace labs_rksp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class ProductController : ControllerBase
    {
        private readonly ProductService _context;

        public ProductController(ProductService context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Product>>> GetProduct()
        {
            return await _context.GetProducts();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Product>> GetProducts(int id)
        {
            var sale = await _context.GetProduct(id);
            if (sale == null)
                return NotFound();

            return sale;
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Order>> PutProduct(int id, [FromBody] Product prodcut)
        {
            var result = await _context.UpdateProduct(id, prodcut);
            if (result == null)
                return BadRequest();

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<Product>> PostProduct([FromBody] ProductDTO product)
        {
            var result = await _context.AddProduct(product);
            if (result == null)
                BadRequest();

            return Ok(result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
            var sale = await _context.DeleteProduct(id);
            if (sale)
                return Ok();

            return BadRequest();
        }
    }
}
