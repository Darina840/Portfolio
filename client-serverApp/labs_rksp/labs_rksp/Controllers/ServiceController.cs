using labs_rksp.Data.DTOs;
using labs_rksp.Data.Services;
using labs_rksp.Data.Models;
using Microsoft.AspNetCore.Mvc;

namespace labs_rksp.Controllers
{
    [Route("api/[controller]")]
    [ApiController]

    public class ServiceController : ControllerBase
    {
        private readonly SService _context;

        public ServiceController(SService context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<Service>>> GetService()
        {
            return await _context.GetServices();
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Service>> GetService(int id)
        {
            var department = await _context.GetService(id);
            if (department == null)
                return NotFound();

            return department;
        }

        [HttpPut("{id}")]
        public async Task<ActionResult<Service>> PutService(int id, [FromBody] Service service)
        {
            var result = await _context.UpdateService(id, service);
            if (result == null)
                return BadRequest();

            return Ok(result);
        }

        [HttpPost]
        public async Task<ActionResult<Service>> PostService([FromBody] ServiceDTO service)
        {
            var result = await _context.AddService(service);
            if (result == null)
                BadRequest();

            return Ok(result);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteService(int id)
        {
            var department = await _context.DeleteService(id);
            if (department)
                return Ok();

            return BadRequest();
        }
    }
}
