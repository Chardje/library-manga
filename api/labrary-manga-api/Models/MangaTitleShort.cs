using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace labrary_manga_api.Models
{
    public class MangaTitleShort
    {
        public int Id { get; set; }

        public string? Title { get; set; }

        public string? Status { get; set; }

        public string? Picture { get; set; }

        public int Chapters { get; set; }

        public MangaTitleShort(Manga manga, int chapters = 0)
        {
            Id = manga.MangaId;
            Title = manga.TitleUa == string.Empty ? manga.TitleUa : manga.Title ?? string.Empty;
            Status = manga.Status ?? string.Empty;
            Picture = manga.Picture;
            Chapters = manga.Chapters?.Count ?? chapters;
        }
    }
}
