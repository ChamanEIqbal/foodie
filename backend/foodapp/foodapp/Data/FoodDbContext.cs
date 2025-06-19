namespace foodapp.Data
{
    using foodapp.Models;
    using Microsoft.EntityFrameworkCore;

    public class FoodieContext : DbContext
    {
        public FoodieContext(DbContextOptions<FoodieContext> options) : base(options) { }

        public DbSet<MenuItem> MenuItems { get; set; }
        public DbSet<SubItem> SubItems { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MenuItem>().HasMany(m => m.SubItems).WithOne().OnDelete(DeleteBehavior.Cascade);
        }
    }
}
