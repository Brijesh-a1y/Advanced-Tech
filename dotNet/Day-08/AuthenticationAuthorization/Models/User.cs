using System.ComponentModel.DataAnnotations;

namespace SPA.Models
{
    public class User
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [EmailAddress]
        public required string Email { get; set; }

        [Required]
        public required string PasswordHash { get; set; }

        public required string FirstName { get; set; }
        public required string LastName { get; set; }

        // Add Role property
        public required string Role { get; set; } = "User";

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}