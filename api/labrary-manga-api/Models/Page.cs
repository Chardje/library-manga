using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("pages")]
    public class Page
    {
        [Key]
        [Column("id")]
        public int Id { get; set; }

        [Column("chapter_id")]
        public int? ChapterId { get; set; }

        [Column("page_number")]
        public int PageNumber { get; set; }

        [Column("image_url")]
        public required string ImageUrl { get; set; }
    }
}
