using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    public class Pack
    {
        [Key]
        [Column("pack_id")]
        public int PackId { get; set; }

        [MaxLength(100)]
        [Column("name")]
        public string? Name { get; set; }

        [Column("description")]
        public string? Description { get; set; }

        public ICollection<Manga> Mangas { get; set; } = new List<Manga>();
    }
}
