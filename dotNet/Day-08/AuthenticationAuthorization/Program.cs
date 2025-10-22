using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using SPA.Data;
using SPA.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Configure Database (InMemory for testing)
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseInMemoryDatabase("AuthDb"));

// Configure JWT Authentication
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"] ?? throw new InvalidOperationException("JWT Key not configured")))
        };
    });

builder.Services.AddAuthorization();

// Register Services
builder.Services.AddScoped<IAuthService, AuthService>();
builder.Services.AddScoped<JwtService>();

var app = builder.Build();

// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Add Authentication & Authorization middleware (IMPORTANT: This order matters!)
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

// Create test users (for development only)
using (var scope = app.Services.CreateScope())
{
    var context = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    var passwordHasher = scope.ServiceProvider.GetRequiredService<IAuthService>();

    // Check if users already exist
    if (!context.Users.Any())
    {
        context.Users.AddRange(
            new SPA.Models.User
            {
                Email = "admin@example.com",
                PasswordHash = PasswordHasher.HashPassword("admin123"),
                FirstName = "Super",
                LastName = "Admin",
                Role = "Admin"
            },
            new SPA.Models.User
            {
                Email = "manager@example.com",
                PasswordHash = PasswordHasher.HashPassword("manager123"),
                FirstName = "John",
                LastName = "Manager",
                Role = "Manager"
            },
            new SPA.Models.User
            {
                Email = "user@example.com",
                PasswordHash = PasswordHasher.HashPassword("user123"),
                FirstName = "Regular",
                LastName = "User",
                Role = "User"
            }
        );
        context.SaveChanges();
        Console.WriteLine("Test users created successfully!");
    }
}

app.Run();
// Add Authentication & Authorization middleware (IMPORTANT: This order matters!)
app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

app.Run();