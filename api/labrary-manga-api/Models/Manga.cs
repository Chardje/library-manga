using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("mangas")]
    public class Manga
    {
        [Key]
        [Column("id")]
        public int MangaId { get; set; }

        [Column("picture")]
        public string? Picture { get; set; }

        [Column("background_picture")]
        public string? BackgroundPicture { get; set; }

        [Required]
        [MaxLength(255)]
        [Column("name")]
        public string Title { get; set; }

        [Column("name_ua")]
        public string? TitleUa { get; set; }

        [Column("release_date")]
        public DateTime? ReleaseDate { get; set; }

        [Column("status")]
        public string? Status { get; set; }

        [Column("number_of_chapters")]
        public int NumberOfChapters { get; set; }

        [Column("description")]
        public string? Description { get; set; }

        // Navigation properties
        public ICollection<MangaAuthor> MangaAuthors { get; set; } = new List<MangaAuthor>();
        public ICollection<MangaGenre> MangaGenres { get; set; } = new List<MangaGenre>();
        public ICollection<Chapter> Chapters { get; set; } = new List<Chapter>();
    }
}
