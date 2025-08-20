using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Models;

namespace labrary_manga_api.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options) { }

    public DbSet<Manga> Mangas { get; set; }
    public DbSet<Author> Authors { get; set; }
    public DbSet<Chapter> Chapters { get; set; }
    public DbSet<Genre> Genres { get; set; }
    public DbSet<MangaAuthor> MangaAuthors { get; set; }
    public DbSet<MangaGenre> MangaGenres { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Composite keys for join tables
        modelBuilder.Entity<MangaAuthor>()
            .HasKey(ma => new { ma.MangaId, ma.AuthorId });

        modelBuilder.Entity<MangaGenre>()
            .HasKey(mg => new { mg.MangaId, mg.GenreId });
    }
}
