using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("manga_genres")]
    public class MangaGenre
    {
        [ForeignKey("Manga")]
        [Column("manga_id")]
        public int MangaId { get; set; }
        public Manga? Manga { get; set; }

        [ForeignKey("Genre")]
        [Column("genre_id")]
        public int GenreId { get; set; }
        public Genre? Genre { get; set; }
    }
}
