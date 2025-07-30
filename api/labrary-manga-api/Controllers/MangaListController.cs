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
                .Take(count)
                .ToListAsync();

            if (manga == null || !manga.Any())
            {
                return NotFound();
            }
            return Ok(new List<MangaTitleShort>(manga.Select(m => new MangaTitleShort(m))));
        }
        [HttpGet("popular")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetPopularManga([FromQuery] int count = 1)
        {
            var manga = await _context.Ratings
                .GroupBy(r => r.MangaId)
                .OrderByDescending(g => g.Average(r => r.RatingValue))
                .Take(count)
                .Select(g => new MangaTitleShort(g.FirstOrDefault().Manga))
                .ToListAsync();

            if (manga == null || !manga.Any())
            {
                return NotFound();
            }
            return Ok(manga);
        }
        [HttpGet("latest")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetLatestManga([FromQuery] int count = 1)
        {
            var manga = await _context.Chapters
                .GroupBy(m => m.MangaId)
                .OrderByDescending(m => m.Max(c => c.TimeUpdated))
                .Select(c => c.FirstOrDefault().Manga)
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
