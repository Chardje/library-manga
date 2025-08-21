using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Data;
using labrary_manga_api.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class DumpController : ControllerBase
    {
        private readonly AppDbContext _context;

        public DumpController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("mangas")]
        public async Task<ActionResult<List<Manga>>> GetAllMangas()
        {
            var result = await _context.Mangas
                .Include(m => m.MangaAuthors)
                .Include(m => m.MangaGenres)
                .Include(m => m.Chapters)
                .ToListAsync();
            return Ok(result);
        }

        [HttpGet("authors")]
        public async Task<ActionResult<List<Author>>> GetAllAuthors()
        {
            var result = await _context.Authors
                .Include(a => a.MangaAuthors)
                .ToListAsync();
            return Ok(result);
        }

        [HttpGet("chapters")]
        public async Task<ActionResult<List<Chapter>>> GetAllChapters()
        {
            var result = await _context.Chapters
                .Include(c => c.Manga)
                .ToListAsync();
            return Ok(result);
        }

        [HttpGet("genres")]
        public async Task<ActionResult<List<Genre>>> GetAllGenres()
        {
            var result = await _context.Genres
                .Include(g => g.MangaGenres)
                .ToListAsync();
            return Ok(result);
        }

        [HttpGet("packs")]
        public async Task<ActionResult<List<Pack>>> GetAllPacks()
        {
            var result = await _context.Set<Pack>()
                .Include(p => p.Mangas)
                .ToListAsync();
            return Ok(result);
        }

        [HttpGet("ratings")]
        public async Task<ActionResult<List<Ratings>>> GetAllRatings()
        {
            var result = await _context.Set<Ratings>()
                .Include(r => r.Manga)
                .ToListAsync();
            return Ok(result);
        }
    }
}
