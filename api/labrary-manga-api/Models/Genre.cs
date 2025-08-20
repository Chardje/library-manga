using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("genres")]
    public class Genre
    {
        [Key]
        [Column("id")]
        public int GenreId { get; set; }

        [Required]
        [MaxLength(100)]
        [Column("name")]
        public string? Name { get; set; }

        public ICollection<MangaGenre> MangaGenres { get; set; } = new List<MangaGenre>();
    }
}
