using labrary_manga_api.Data;
using labrary_manga_api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MangaUnitController : ControllerBase
    {
        private readonly AppDbContext _context;

        public MangaUnitController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<Manga>> GetMangaUnit(int id)
        {
            var manga = await _context
                .Mangas.Include(m => m.Chapters)
                .Include(m => m.MangaAuthors)
                .ThenInclude(ma => ma.Author)
                .FirstOrDefaultAsync(m => m.MangaId == id);
            if (manga == null)
                return NotFound();
            return Ok(manga);
        }
    }
}
