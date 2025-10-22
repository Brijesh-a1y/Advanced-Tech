using Microsoft.AspNetCore.Mvc;
using SPA.Models;
using SPA.Services;
using SPA.Models;
using SPA.Services;
using System.Security.Claims;

namespace SPA.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _authService;
        private readonly JwtService _jwtService;

        public AuthController(IAuthService authService, JwtService jwtService)
        {
            _authService = authService;
            _jwtService = jwtService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterRequest request)
        {
            var user = await _authService.RegisterAsync(
                request.Email,
                request.Password,
                request.FirstName,
                request.LastName,
                request.Role); // Make sure to pass the role parameter

            if (user == null)
                return BadRequest(new { message = "User already exists" });

            return Ok(new { message = "User registered successfully", role = user.Role });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginRequest request)
        {
            var user = await _authService.LoginAsync(request.Email, request.Password);

            if (user == null)
                return Unauthorized(new { message = "Invalid credentials" });

            var token = _jwtService.GenerateToken(user);

            return Ok(new LoginResponse
            {
                Token = token,
                Expiration = DateTime.Now.AddHours(1),
                Email = user.Email
            });
        }

        // New endpoint to get current user info (including role)
        [HttpGet("me")]
        public async Task<IActionResult> GetCurrentUser()
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
    }
}