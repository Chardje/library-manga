using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("manga")]
    public class Manga
    {
        [Key]
        [Column("manga_id")]
        public int MangaId { get; set; }

        [Required]
        [MaxLength(200)]
        [Column("title")]
        public string Title { get; set; }

        [Column("description")]
        public string? Description { get; set; }

        [Column("release_date")]
        public DateTime? ReleaseDate { get; set; }

        [ForeignKey("Author")]
        [Column("author_id")]
        public int? AuthorId { get; set; }

        public Author? Author { get; set; }

        [ForeignKey("Pack")]
        [Column("pack_id")]
        public int? PackId { get; set; }

        public Pack? Pack { get; set; }

        [Column("created_at")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        [Column("cover_image")]
        public string? CoverImage { get; set; }
        [Column("status")]
        public string Status { get; set; } = "Ended";

        public List<Chapter> Chapters { get; set; }
    }
}
