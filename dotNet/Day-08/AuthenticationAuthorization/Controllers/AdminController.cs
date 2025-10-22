using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SPA.Services;
using System.Security.Claims;
using SPA.Data;

namespace SPA.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize(Roles = "Admin")] // Only Admin can access all endpoints in this controller
    public class AdminController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly AppDbContext _context;

        public AdminController(IAuthService authService, AppDbContext context)
        {
            _authService = authService;
            _context = context;
        }

        [HttpGet("users")]
        public IActionResult GetAllUsers()
        {
            var users = _context.Users.Select(u => new
            {
                u.Id,
                u.Email,
                u.FirstName,
                u.LastName,
                u.Role,
                u.CreatedAt
            }).ToList();

            return Ok(users);
        }

        [HttpPut("users/{userId}/role")]
        public async Task<IActionResult> UpdateUserRole(int userId, [FromBody] UpdateRoleRequest request)
        {
            var currentAdminId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");

            // Prevent admin from changing their own role
            if (userId == currentAdminId)
            {
                return BadRequest(new { message = "Cannot change your own role" });
            }

            var result = await _authService.UpdateUserRoleAsync(userId, request.NewRole);

            if (!result)
                return BadRequest(new { message = "Failed to update user role" });

            return Ok(new { message = $"User role updated to {request.NewRole}" });
        }

        [HttpGet("stats")]
        public IActionResult GetStats()
        {
            var stats = new
            {
                TotalUsers = _context.Users.Count(),
                UsersByRole = _context.Users
                    .GroupBy(u => u.Role)
                    .Select(g => new { Role = g.Key, Count = g.Count() })
                    .ToList(),
                LatestRegistrations = _context.Users
                    .OrderByDescending(u => u.CreatedAt)
                    .Take(5)
                    .Select(u => new { u.Email, u.Role, u.CreatedAt })
                    .ToList()
            };

            return Ok(stats);
        }
    }

    public class UpdateRoleRequest
    {
        public required string NewRole { get; set; }
    }
}