using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Identity;
using Npgsql.Replication;

namespace Rest_API;

public static class AuthEndpoints
{
    public static void AddAuthApi(this WebApplication app)
    {
        app.MapPost(
            "api/register",
            async (UserManager<LandlordRestUser> userManager, RegisterUserDto registerUserDto) =>
            {
                var user = await userManager.FindByNameAsync(registerUserDto.Username);
                if (user != null)
                    return Results.UnprocessableEntity("Username already taken");

                var newUser = new LandlordRestUser
                {
                    Email = registerUserDto.Email,
                    UserName = registerUserDto.Username,
                };

                var createUserResult = await userManager.CreateAsync(
                    newUser,
                    registerUserDto.Password
                );
                if (!createUserResult.Succeeded)
                {
                    return Results.UnprocessableEntity();
                }
                if (registerUserDto.Role == "Simple")
                {
                    await userManager.AddToRoleAsync(newUser, LandlordRoles.Simple);
                }
                else if (registerUserDto.Role == "Landlord")
                {
                    await userManager.AddToRoleAsync(newUser, LandlordRoles.Landlord);
                }

                return Results.Created(
                    "api/login",
                    new UserDto(newUser.Id, newUser.UserName, newUser.Email)
                );
            }
        );

        app.MapPost(
            "api/login",
            async (
                UserManager<LandlordRestUser> userManager,
                JwtTokenService jwtTokenService,
                LoginDto loginDto,
                SessionService sessionService,
                HttpContext httpContext
            ) =>
            {
                var user = await userManager.FindByNameAsync(loginDto.Username);
                if (user == null)
                    return Results.UnprocessableEntity("Username or password was incorrect.");

                var isPasswordValid = await userManager.CheckPasswordAsync(user, loginDto.Password);
                if (!isPasswordValid)
                {
                    return Results.UnprocessableEntity("Username or password was incorrect.");
                }

                await userManager.UpdateAsync(user);
                var sessionId = Guid.NewGuid();
                var expiresAt = DateTime.UtcNow.AddDays(3);
                var roles = await userManager.GetRolesAsync(user);
                var accessToken = jwtTokenService.CreateAccessToken(user.UserName, user.Id, roles);
                var refreshToken = jwtTokenService.CreateRefreshToken(
                    sessionId,
                    user.Id,
                    expiresAt
                );
                await sessionService.CreateSessionAsync(
                    sessionId,
                    user.Id,
                    refreshToken,
                    expiresAt
                );
                var cookieOptions = new CookieOptions
                {
                    HttpOnly = true,
                    SameSite = SameSiteMode.Lax,
                    Expires = expiresAt,
                    //Secure = false => should be true possibly
                };

                httpContext.Response.Cookies.Append("RefreshToken", refreshToken, cookieOptions);

                return Results.Ok(new SuccesfulLoginDto(accessToken, refreshToken));
            }
        );

        app.MapPost(
            "api/accessToken",
            async (
                UserManager<LandlordRestUser> userManager,
                JwtTokenService jwtTokenService,
                SessionService sessionService,
                HttpContext httpContext
            ) =>
            {
                if (!httpContext.Request.Cookies.TryGetValue("RefreshToken", out var refreshToken))
                {
                    return Results.UnprocessableEntity();
                }

                if (!jwtTokenService.TryParseRefreshToken(refreshToken, out var claims))
                {
                    return Results.UnprocessableEntity();
                }

                var sessionId = claims.FindFirstValue("SessionId");
                if (string.IsNullOrWhiteSpace(sessionId))
                {
                    return Results.UnprocessableEntity();
                }

                var sessionIdAsGuid = Guid.Parse(sessionId);
                if (!await sessionService.IsSessionValidAsync(sessionIdAsGuid, refreshToken))
                {
                    return Results.UnprocessableEntity();
                }

                var userId = claims.FindFirstValue(JwtRegisteredClaimNames.Sub);
                var user = await userManager.FindByIdAsync(userId);
                if (user == null)
                {
                    return Results.UnprocessableEntity();
                }

                var roles = await userManager.GetRolesAsync(user);

                var expiresAt = DateTime.UtcNow.AddDays(3);
                var accessToken = jwtTokenService.CreateAccessToken(user.UserName, user.Id, roles);
                var newRefreshToken = jwtTokenService.CreateRefreshToken(
                    sessionIdAsGuid,
                    user.Id,
                    expiresAt
                );

                var cookieOptions = new CookieOptions
                {
                    HttpOnly = true,
                    SameSite = SameSiteMode.Lax,
                    Expires = expiresAt,
                    //Secure = false => should be true possibly
                };

                httpContext.Response.Cookies.Append("RefreshToken", newRefreshToken, cookieOptions);

                await sessionService.ExtendSessionAsync(
                    sessionIdAsGuid,
                    newRefreshToken,
                    expiresAt
                );

                return Results.Ok(new SuccesfulLoginDto(accessToken, refreshToken));
            }
        );

        app.MapPost(
            "api/logout",
            async (
                UserManager<LandlordRestUser> userManager,
                JwtTokenService jwtTokenService,
                SessionService sessionService,
                HttpContext httpContext
            ) =>
            {
                if (!httpContext.Request.Cookies.TryGetValue("RefreshToken", out var refreshToken))
                {
                    return Results.UnprocessableEntity();
                }

                if (!jwtTokenService.TryParseRefreshToken(refreshToken, out var claims))
                {
                    return Results.UnprocessableEntity();
                }

                var sessionId = claims.FindFirstValue("SessionId");
                if (string.IsNullOrWhiteSpace(sessionId))
                {
                    return Results.UnprocessableEntity();
                }

                await sessionService.InvalidateSessionAsync(Guid.Parse(sessionId));
                httpContext.Response.Cookies.Delete("RefreshToken");

                return Results.Ok();
            }
        );
    }
}

public record RegisterUserDto(string Username, string Password, string Email, string Role);

public record UserDto(string UserId, string Email, string UserName);

public record LoginDto(string Username, string Password);

public record SuccesfulLoginDto(string AccessToken, string RefreshToken);

public record RefreshAccessTokenDto(string RefreshToken);
