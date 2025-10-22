using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SPA.Services;
using System.Security.Claims;

namespace SPA.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    [Authorize] // Requires authentication for all endpoints in this controller
    public class ProtectedController : ControllerBase
    {
        private readonly IAuthService _authService;

        public ProtectedController(IAuthService authService)
        {
            _authService = authService;
        }

        [HttpGet("profile")]
        public async Task<IActionResult> GetProfile()
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier)?.Value ?? "0");
            var user = await _authService.GetUserByIdAsync(userId);

            if (user == null)
                return NotFound();

            return Ok(new
            {
                user.Id,
                user.Email,
                user.FirstName,
                user.LastName,
                user.Role,
                user.CreatedAt
            });
        }

        // Role-based authorization examples:

        [HttpGet("admin-only")]
        [Authorize(Roles = "Admin")] // Only users with Admin role can access
        public IActionResult AdminOnly()
        {
            return Ok(new
            {
                message = "This is accessible only by Admin users",
                userRole = User.FindFirst(ClaimTypes.Role)?.Value,
                timestamp = DateTime.UtcNow
            });
        }

        [HttpGet("manager-dashboard")]
        [Authorize(Roles = "Admin,Manager")] // Both Admin and Manager can access
        public IActionResult ManagerDashboard()
        {
            return Ok(new
            {
                message = "Welcome to Manager Dashboard",
                accessibleTo = "Admin and Manager roles",
                userRole = User.FindFirst(ClaimTypes.Role)?.Value
            });
        }

        [HttpGet("user-data")]
        [Authorize(Roles = "Admin,Manager,User")] // All authenticated users can access
        public IActionResult UserData()
        {
            return Ok(new
            {
                message = "This is accessible by all authenticated users",
                userRole = User.FindFirst(ClaimTypes.Role)?.Value,
                data = "Some user data here"
            });
        }

        [HttpGet("public")]
        [AllowAnonymous] // No authentication required
        public IActionResult PublicEndpoint()
        {
            return Ok(new { message = "This is a public endpoint - no authentication required" });
        }

        // Endpoint to demonstrate multiple role checks
        [HttpGet("role-check")]
        public IActionResult RoleCheck()
        {
            var userRole = User.FindFirst(ClaimTypes.Role)?.Value;
            var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
            var userEmail = User.FindFirst(ClaimTypes.Email)?.Value;

            return Ok(new
            {
                message = "Role information",
                userId,
                userEmail,
                userRole,
                isAdmin = User.IsInRole("Admin"),
                isManager = User.IsInRole("Manager"),
                isUser = User.IsInRole("User"),
                allRoles = new[] { "Admin", "Manager", "User" }.Where(role => User.IsInRole(role)).ToList()
            });
        }
    }
}