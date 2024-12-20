using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Rest_API.Data.Entities;

public class LandlordDbContext : IdentityDbContext<LandlordRestUser>
{
    private readonly IConfiguration _configuration;
    public DbSet<Landlord> Landlords { get; set; }
    public DbSet<Building> Buildings { get; set; }
    public DbSet<Flat> Flats { get; set; }
    public DbSet<Session> Sessions { get; set; }

    public LandlordDbContext(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseNpgsql(_configuration.GetConnectionString("PostgreSQL"));
    }
}
