using SPA.Data;
using SPA.Models;
using Microsoft.EntityFrameworkCore;
using SPA.Data;
using SPA.Models;
using SPA.Services;

namespace SPA.Services
{
    public class AuthService : IAuthService
    {
        private readonly AppDbContext _context;

        public AuthService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<User?> RegisterAsync(string email, string password, string firstName, string lastName, string role = "User")
        {
            // Check if user already exists
            if (await _context.Users.AnyAsync(u => u.Email == email))
                return null;

            // Validate role
            var validRoles = new[] { "User", "Admin", "Manager" };
            if (!validRoles.Contains(role))
                role = "User";

            var user = new User
            {
                Email = email,
                PasswordHash = PasswordHasher.HashPassword(password),
                FirstName = firstName,
                LastName = lastName,
                Role = role
            };

            _context.Users.Add(user);
            await _context.SaveChangesAsync();

            return user;
        }

        public async Task<User?> LoginAsync(string email, string password)
        {
            var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);

            if (user == null || !PasswordHasher.VerifyPassword(password, user.PasswordHash))
                return null;

            return user;
        }

        public async Task<User?> GetUserByIdAsync(int id)
        {
            return await _context.Users.FindAsync(id);
        }

        // New method to update user role
        public async Task<bool> UpdateUserRoleAsync(int userId, string newRole)
        {
            var user = await _context.Users.FindAsync(userId);
            if (user == null) return false;

            var validRoles = new[] { "User", "Admin", "Manager" };
            if (!validRoles.Contains(newRole)) return false;

            user.Role = newRole;
            await _context.SaveChangesAsync();
            return true;
        }
    }
}