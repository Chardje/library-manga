using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Data;
using labrary_manga_api.Models;


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
        public async Task<ActionResult<List<MangaTitleShort>>> GetRandomManga([FromQuery] int count = 1)
        {
            var manga = await _context.Manga
                .OrderBy(m => Guid.NewGuid())
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
        [HttpGet("popular")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetPopularManga([FromQuery] int count = 1)
        {
            var popularMangaIds = await _context.Ratings
                .GroupBy(r => r.MangaId)
                .OrderByDescending(g => g.Average(r => r.RatingValue))
                .Take(count)
                .Select(g => g.Key)
                .ToListAsync();

            var manga = await _context.Manga
                .Where(m => popularMangaIds.Contains(m.MangaId))
                .Include(m => m.Chapters)
                .ToListAsync();

            var result = manga.Select(m => new MangaTitleShort(m)).ToList();

            if (result == null || !result.Any())
            {
                return NotFound();
            }
            return Ok(result);
        }
        [HttpGet("latest")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetLatestManga([FromQuery] int count = 1)
        {
            var latestMangaIds = await _context.Chapters
                .GroupBy(c => c.MangaId)
                .OrderByDescending(g => g.Max(c => c.TimeUpdated))
                .Take(count)
                .Select(g => g.Key)
                .ToListAsync();

            var manga = await _context.Manga
                .Where(m => latestMangaIds.Contains(m.MangaId))
                .Include(m => m.Chapters)
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
