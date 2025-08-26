using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Data;
using labrary_manga_api.Models;
using System.Linq;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class VidgetController : ControllerBase
    {
        private readonly AppDbContext _context;

        public VidgetController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet("carousel")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetCarousel()
        {
            var mangas = await _context.Mangas
                .Where(m => m.Vidget == "carousel")
                .Include(m => m.Chapters)
                .ToListAsync();

            var result = mangas.Select(m => new MangaTitleShort(m)).ToList();

            return Ok(result);
        }

        [HttpGet("popular")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetPopular()
        {
            var mangas = await _context.Mangas
                .Where(m => m.Vidget == "popular")
                .Include(m => m.Chapters)
                .ToListAsync();

            var result = mangas.Select(m => new MangaTitleShort(m)).ToList();

            return Ok(result);
        }

        [HttpGet("latest")]
        public async Task<ActionResult<List<MangaTitleShort>>> GetLatest()
        {
            var mangas = await _context.Mangas
                .Where(m => m.Vidget == "latest")
                .Include(m => m.Chapters)
                .ToListAsync();

            var result = mangas.Select(m => new MangaTitleShort(m)).ToList();

            return Ok(result);
        }
    }
}