using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Data;
using labrary_manga_api.Models;


namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class RandomMangaController : ControllerBase
    {
        private readonly AppDbContext _context;

        public RandomMangaController(AppDbContext context)
        {
            _context = context;
        }
        [HttpGet("random")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetRandomManga([FromQuery] int count = 1)
        {
            var manga = await _context.Manga
                .OrderBy(m => Guid.NewGuid())
                .Take(count)
                .ToListAsync();

            if (manga == null || !manga.Any())
            {
                return NotFound();
            }
            return Ok(new List<MangaTitleShort>(manga.Select(m => new MangaTitleShort(m))));
        }
    }
}
