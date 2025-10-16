
using EntityProject.Models.Entities;
using Microsoft.EntityFrameworkCore;

namespace EntityProject.Data
{
    public class ApplicationDbContext:DbContext
    {
        public ApplicationDbContext(DbContextOptions options) : base(options) { }

        public DbSet<Product> Products { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            var fixedDate = new DateTime(2024, 1, 1, 0, 0, 0); // Fixed date for all seeded data

            modelBuilder.Entity<Product>().HasData(
                new Product
                {
                    Id = 1,
                    Name = "Laptop",
                    Description = "High performace Laptop",
                    Price = 50,
                    StockQuantity = 10,
                    IsActive = true,
                    CreatedDate = fixedDate,
                    
                },
                new Product
                {
                    Id = 2,
                    Name = "Mouse",
                    Description = "Wireless computer mouse",
                    Price = 15,
                    StockQuantity = 25,
                    CreatedDate = fixedDate,
                    IsActive = true
                },
                new Product
                {
                    Id = 3, 
                    Name = "Keyboard",
                    Description = "Mechanical gaming keyboard",
                    Price = 45,
                    StockQuantity = 15,
                    CreatedDate = fixedDate,
                    IsActive = true
                }
            );
        }
    }
}
