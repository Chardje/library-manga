using labrary_manga_api.Data;
using labrary_manga_api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MangaListController : ControllerBase
    {
        private readonly AppDbContext _context;

        public MangaListController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("random")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetRandomManga(
            [FromQuery] int count = 1
        )
        {
            var manga = await _context
                .Mangas.OrderBy(m => Guid.NewGuid())
                .Include(m => m.Chapters)
                .Take(count)
                .ToListAsync();

            var result = manga.Select(m => new MangaTitleShort(m)).ToList();

            if (result == null || !result.Any())
            {
                return NotFound();
            }
            return Ok(result);
        }

        [HttpGet("latest")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetLatestManga(
            [FromQuery] int count = 1
        )
        {
            var manga = await _context
                .Mangas.OrderByDescending(m => m.ReleaseDate)
                .Include(m => m.Chapters)
                .Take(count)
                .ToListAsync();

            var result = manga.Select(m => new MangaTitleShort(m)).ToList();

            if (result == null || !result.Any())
            {
                return NotFound();
            }
            return Ok(result);
        }
    }
}
