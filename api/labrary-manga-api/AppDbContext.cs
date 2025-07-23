using Microsoft.EntityFrameworkCore;
using labrary_manga_api.Models;

namespace labrary_manga_api.Data;

public class AppDbContext : DbContext
{
    public AppDbContext(DbContextOptions<AppDbContext> options)
        : base(options) { }

    public DbSet<Manga> Manga { get; set; }
    public DbSet<Author> Authors { get; set; }
    public DbSet<Pack> Packs { get; set; }
    public DbSet<Ratings> Ratings { get; set; }
    public DbSet<Chapter> Chapters { get; set; }
}
