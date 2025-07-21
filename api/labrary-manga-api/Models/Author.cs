using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    public class Author
    {
        [Key]
        [Column("author_id")]
        public int AuthorId { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("name")]
        public string Name { get; set; }

        [Column("bio")]
        public string? Bio { get; set; }

        public ICollection<Manga> Mangas { get; set; } = new List<Manga>();
    }
}
