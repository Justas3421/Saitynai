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
                await userManager.AddToRoleAsync(newUser, LandlordRoles.Simple);

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
                LoginDto loginDto
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

                user.ForceRelogin = false;
                await userManager.UpdateAsync(user);

                var roles = await userManager.GetRolesAsync(user);
                var accessToken = jwtTokenService.CreateAccessToken(user.UserName, user.Id, roles);
                var refreshToken = jwtTokenService.CreateRefreshToken(user.Id);
                return Results.Ok(new SuccesfulLoginDto(accessToken, refreshToken));
            }
        );

        app.MapPost(
            "api/accessToken",
            async (
                UserManager<LandlordRestUser> userManager,
                JwtTokenService jwtTokenService,
                RefreshAccessTokenDto tokenDto
            ) =>
            {
                if (!jwtTokenService.TryParseRefreshToken(tokenDto.RefreshToken, out var claims))
                {
                    return Results.UnprocessableEntity();
                }
                var userId = claims.FindFirstValue(JwtRegisteredClaimNames.Sub);
                var user = await userManager.FindByIdAsync(userId);
                if (user == null)
                {
                    return Results.UnprocessableEntity("Invalid token");
                }
                if (user.ForceRelogin)
                {
                    return Results.UnprocessableEntity();
                }

                var roles = await userManager.GetRolesAsync(user);
                var accessToken = jwtTokenService.CreateAccessToken(user.UserName, user.Id, roles);
                var refreshToken = jwtTokenService.CreateRefreshToken(user.Id);
                return Results.Ok(new SuccesfulLoginDto(accessToken, refreshToken));
            }
        );
    }
}

public record RegisterUserDto(string Username, string Password, string Email);

public record UserDto(string UserId, string Email, string UserName);

public record LoginDto(string Username, string Password);

public record SuccesfulLoginDto(string AccessToken, string RefreshToken);

public record RefreshAccessTokenDto(string RefreshToken);
