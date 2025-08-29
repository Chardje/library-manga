using labrary_manga_api.Data;
using labrary_manga_api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class PageController : ControllerBase
    {
        private readonly AppDbContext _context;

        public PageController(AppDbContext context)
        {
            _context = context;
        }

        // Сторінки за id розділу
        [HttpGet("by-chapter/{chapterId}")]
        public async Task<ActionResult<List<Page>>> GetPagesByChapterId(int chapterId)
        {
            var result = await _context
                .Set<Page>()
                .Where(p => p.ChapterId == chapterId)
                .ToListAsync();
            return Ok(result);
        }
    }
}
