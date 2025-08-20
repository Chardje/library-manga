using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace labrary_manga_api.Models
{
    public class MangaTitleShort
    {
        public int Id { get; set; }

        public string Title { get; set; }

        public string Status { get; set; }

        public string? Picture { get; set; }

        public int Chapters { get; set; }

        public MangaTitleShort(Manga manga , int chapters = 0)
        {
            Id = manga.MangaId;
            Title = manga.Title;
            Status = manga.Status;
            Picture = manga.Picture;
            Chapters = manga.Chapters?.Count ?? chapters;
        }

    }
}