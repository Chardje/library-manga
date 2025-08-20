using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Data;
using labrary_manga_api.Models;


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
        public async Task<ActionResult<MangaUnit>> GetMangaUnit(int id)
        {
            var manga = await _context.Mangas
            .FirstOrDefaultAsync(m => m.MangaId == id)
                .Include(m => m.Chapters)
                .Include(m => m.MangaAuthors)
                .ThenInclude(ma => ma.Author);
            if (manga == null)
                return NotFound();
            return Ok(new MangaUnit(manga));
        }
    }
}
