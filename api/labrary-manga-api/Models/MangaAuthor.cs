using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("manga_authors")]
    public class MangaAuthor
    {
        [ForeignKey("Manga")]
        [Column("manga_id")]
        public int MangaId { get; set; }
        public Manga? Manga { get; set; }

        [ForeignKey("Author")]
        [Column("author_id")]
        public int AuthorId { get; set; }
        public Author? Author { get; set; }

        [Column("role")]
        public string? Role { get; set; }
    }
}
