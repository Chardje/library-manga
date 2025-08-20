using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("chapters")]
    public class Chapter
    {
        [Key]
        [Column("id")]
        public int ChapterId { get; set; }

        [ForeignKey("Manga")]
        [Column("manga_id")]
        public int MangaId { get; set; }

        [Column("chapter_number")]
        public int ChapterNumber { get; set; }

        [Column("title")]
        public string? Title { get; set; }

        [Column("release_date")]
        public DateTime? ReleaseDate { get; set; }

        public Manga? Manga { get; set; }
    }
}