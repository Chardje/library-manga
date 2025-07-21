using System.ComponentModel.DataAnnotations;

namespace labrary_manga_api.Models
{
    public class MangaTitleShort
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Status { get; set; }

        public string CoverImage { get; set; }

        public int Chapters { get; set; }

        public MangaTitleShort(Manga manga)
        {
            Id = manga.MangaId;
            Title = manga.Title;
            Status = manga.Status;
            CoverImage = manga.CoverImage;
            Chapters = 0;
        }

    }
}