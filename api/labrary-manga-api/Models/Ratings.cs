using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using labrary_manga_api.Data;
using Microsoft.EntityFrameworkCore;

namespace labrary_manga_api.Models
{
    [Table("ratings")]
    public class Ratings
    {

        [Key]
        [Column("rating_id")]
        public int RatingId { get; set; }

        [ForeignKey("Manga")]
        [Column("manga_id")]
        public int MangaId { get; set; }

        [Column("rating")]
        public double RatingValue { get; set; } = 0.0;

        [Column("rated_at")]
        public DateTime RatedAt { get; set; } = DateTime.UtcNow;

        public virtual Manga? Manga { get; set; }
    }
}