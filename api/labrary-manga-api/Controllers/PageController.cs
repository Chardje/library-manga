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
                .Pages.Where(p => p.ChapterId == chapterId)
                .OrderBy(p => p.PageNumber)
                .ToListAsync();
            return Ok(result);
        }

        [HttpGet("by-chapter/{mangaId}/{chapterNumber}")]
        public async Task<ActionResult<List<Page>>> GetPagesByChapter(
            int mangaId,
            int chapterNumber
        )
        {
            var chapter = await _context.Chapters.FirstOrDefaultAsync(c =>
                c.MangaId == mangaId && c.ChapterNumber == chapterNumber
            );

            if (chapter == null)
                return NotFound();

            var result = await _context
                .Pages.Where(p => p.ChapterId == chapter.ChapterId)
                .OrderBy(p => p.PageNumber)
                .ToListAsync();

            return Ok(result);
        }
    }
}
