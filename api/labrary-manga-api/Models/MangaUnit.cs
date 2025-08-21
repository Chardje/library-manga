using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace labrary_manga_api.Models
{
    public class MangaUnit
    {
        public int Id { get; set; }

        public string? Title { get; set; } 

        public string? Status { get; set; } 

        public string? Picture { get; set; }

        public List<Chapter> Chapters { get; set; }

        public List<Author>? Authors { get; set; }

        public MangaUnit(Manga manga)
        {
            Id = manga.MangaId;
            Title = manga.Title ?? string.Empty;
            Status = manga.Status ?? string.Empty;
            Picture = manga.Picture;
            Chapters = manga.Chapters?.ToList() ?? new List<Chapter>();
        }

    }
}