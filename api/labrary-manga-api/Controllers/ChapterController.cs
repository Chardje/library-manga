using labrary_manga_api.Data;
using labrary_manga_api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ChapterControler : ControllerBase
    {
        private readonly AppDbContext _context;

        public ChapterControler(AppDbContext context)
        {
            _context = context;
        }

        // GET: /Chapter/by-manga/{mangaId}
        [HttpGet("by-manga/{mangaId}")]
        public async Task<ActionResult<List<Chapter>>> GetChaptersByMangaId(int mangaId)
        {
            var chapters = await _context.Chapters
                .Where(c => c.MangaId == mangaId)
                .OrderBy(c => c.ChapterNumber)
                .ToListAsync();

            return Ok(chapters);
        }
    }
}
