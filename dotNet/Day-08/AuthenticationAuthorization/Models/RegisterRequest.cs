using System.ComponentModel.DataAnnotations;

namespace SPA.Models
{
    public class RegisterRequest
    {
        [Required]
        [EmailAddress]
        public required string Email { get; set; }

        [Required]
        [MinLength(6)]
        public required string Password { get; set; }

        [Required]
        public required string FirstName { get; set; }

        [Required]
        public required string LastName { get; set; }

        // Optional: Add role during registration (default to "User")
        public string Role { get; set; } = "User";
    }
}