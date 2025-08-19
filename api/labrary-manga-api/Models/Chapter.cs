using System.ComponentModel.DataAnnotations.Schema;

namespace labrary_manga_api.Models
{
    [Table("chapter")]
    public class Chapter
    {
        [Column("chapter_id")]
        public int ChapterId { get; set; }


        [ForeignKey("Manga")]
        [Column("manga_id")]
        public int MangaId { get; set; }        


        [Column("num")]
        public int ChapterNumber { get; set; }


        [Column("time_updated")]
        public DateTime TimeUpdated { get; set; }
    }
}