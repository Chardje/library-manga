using System.ComponentModel.DataAnnotations;

namespace labrary_manga_api.Models
{
    public class MangaUnit
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Status { get; set; }

        public string CoverImage { get; set; }

        public List<Chapter> Chapters { get; set; }

        public MangaUnit(Manga manga)
        {
            Id = manga.MangaId;
            Title = manga.Title;
            Status = manga.Status;
            CoverImage = manga.CoverImage;
            Chapters = manga.Chapters ?? new List<Chapter>();
        }

    }
}