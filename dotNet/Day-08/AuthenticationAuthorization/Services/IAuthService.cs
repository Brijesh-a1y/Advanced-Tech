using SPA.Models;

namespace SPA.Services
{
    public interface IAuthService
    {
        Task<User?> RegisterAsync(string email, string password, string firstName, string lastName, string role = "User");
        Task<User?> LoginAsync(string email, string password);
        Task<User?> GetUserByIdAsync(int id);
        Task<bool> UpdateUserRoleAsync(int userId, string newRole); // Add this new method
    }
}