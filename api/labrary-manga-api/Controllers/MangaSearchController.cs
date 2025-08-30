using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using labrary_manga_api.Data;
using labrary_manga_api.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace labrary_manga_api.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class MangaSearchController : ControllerBase
    {
        private readonly AppDbContext _context;
        private const int DefaultLimit = 20;

        public MangaSearchController(AppDbContext context)
        {
            _context = context;
        }

        [HttpGet]
        public async Task<ActionResult<List<MangaTitleShort>>> Search(
            [FromQuery] DateTime? releaseDateFrom,
            [FromQuery] DateTime? releaseDateTo,
            [FromQuery] string? title,
            [FromQuery] string? author,
            [FromQuery] int? chaptersFrom,
            [FromQuery] int? chaptersTo,
            [FromQuery] string? status,
            [FromQuery] int? count
        )
        {
            var query = _context
                .Mangas.Include(m => m.Chapters)
                .Include(m => m.MangaAuthors)
                .ThenInclude(ma => ma.Author)
                .AsQueryable();

            if (releaseDateFrom.HasValue)
                query = query.Where(m => m.ReleaseDate >= releaseDateFrom.Value);

            if (releaseDateTo.HasValue)
                query = query.Where(m => m.ReleaseDate <= releaseDateTo.Value);

            if (!string.IsNullOrWhiteSpace(title))
                query = query.Where(m =>
                    (
                        !string.IsNullOrEmpty(m.Title)
                        && EF.Functions.ILike(m.Title ?? string.Empty, $"%{title}%")
                    )
                    || (
                        !string.IsNullOrEmpty(m.TitleUa)
                        && EF.Functions.ILike(m.TitleUa ?? string.Empty, $"%{title}%")
                    )
                );

            if (!string.IsNullOrWhiteSpace(author))
                query = query.Where(m =>
                    m.MangaAuthors.Any(ma =>
                        ma.Author != null
                        && EF.Functions.ILike(ma.Author.Name ?? string.Empty, $"%{author}%")
                    )
                );

            if (chaptersFrom.HasValue)
                query = query.Where(m => m.NumberOfChapters >= chaptersFrom.Value);

            if (chaptersTo.HasValue)
                query = query.Where(m => m.NumberOfChapters <= chaptersTo.Value);

            if (!string.IsNullOrWhiteSpace(status))
                query = query.Where(m => m.Status != null && m.Status == status);

            int takeCount = count ?? DefaultLimit;

            var result = await query
                .OrderByDescending(m => m.ReleaseDate)
                .Take(takeCount)
                .ToListAsync();

            var mapped = result.Select(m => new MangaTitleShort(m)).ToList();

            if (!mapped.Any())
                return NotFound();

            return Ok(mapped);
        }
    }
}
