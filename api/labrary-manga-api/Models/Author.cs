using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("authors")]
    public class Author
    {
        [Key]
        [Column("id")]
        public int AuthorId { get; set; }

        [Required]
        [MaxLength(255)]
        [Column("name")]
        public string? Name { get; set; }

        // Navigation property for mangas (many-to-many)
        public ICollection<MangaAuthor> MangaAuthors { get; set; } = new List<MangaAuthor>();
    }
}

