using labrary_manga_api.Models;
using Microsoft.EntityFrameworkCore;

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
    public DbSet<Page> Pages { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        // Table names
        modelBuilder.Entity<Manga>().ToTable("mangas");
        modelBuilder.Entity<Author>().ToTable("authors");
        modelBuilder.Entity<Chapter>().ToTable("chapters");
        modelBuilder.Entity<Genre>().ToTable("genres");
        modelBuilder.Entity<MangaAuthor>().ToTable("manga_authors");
        modelBuilder.Entity<MangaGenre>().ToTable("manga_genres");
        modelBuilder.Entity<Page>().ToTable("pages");

        // Composite keys for join tables
        modelBuilder.Entity<MangaAuthor>().HasKey(ma => new { ma.MangaId, ma.AuthorId });

        modelBuilder.Entity<MangaGenre>().HasKey(mg => new { mg.MangaId, mg.GenreId });

        // Enum mapping (Postgres)
        modelBuilder.Entity<Manga>().Property(m => m.Status).HasColumnType("manga_status");

        modelBuilder.Entity<Manga>().Property(m => m.Vidget).HasColumnType("manga_vidget");

        modelBuilder.Entity<MangaAuthor>().Property(ma => ma.Role).HasColumnType("author_role");
    }
}
