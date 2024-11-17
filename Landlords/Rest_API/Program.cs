using System.IdentityModel.Tokens.Jwt;
using System.Text;
using FluentValidation;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Rest_API;
using Rest_API.Data.Entities;
using SharpGrip.FluentValidation.AutoValidation.Endpoints.Extensions;
using SharpGrip.FluentValidation.AutoValidation.Endpoints.Results;
using SharpGrip.FluentValidation.AutoValidation.Shared.Extensions;

JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<LandlordDbContext>();
builder.Services.AddValidatorsFromAssemblyContaining<Program>();
builder.Services.AddTransient<JwtTokenService>();
builder.Services.AddTransient<SessionService>();
builder.Services.AddScoped<AuthDbSeeder>();
builder.Services.AddFluentValidationAutoValidation(configuration =>
{
    configuration.OverrideDefaultResultFactoryWith<ProblemDetailsResultFactory>();
});

builder
    .Services.AddIdentity<LandlordRestUser, IdentityRole>()
    .AddEntityFrameworkStores<LandlordDbContext>()
    .AddDefaultTokenProviders();
builder
    .Services.AddAuthentication(options =>
    {
        options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
        options.DefaultScheme = JwtBearerDefaults.AuthenticationScheme;
    })
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters.ValidAudience = builder.Configuration[
            "Jwt:ValidAudience"
        ];
        options.TokenValidationParameters.ValidIssuer = builder.Configuration["Jwt:ValidIssuer"];
        options.TokenValidationParameters.IssuerSigningKey = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Secret"])
        );
    });
builder.Services.AddAuthorization();
var app = builder.Build();
app.AddAuthApi();
app.AddLandlordApiEndpoints();
app.AddBuildingsApiEndpoints();
app.AddFlatsApiEndpoints();
app.UseAuthentication();
app.UseAuthorization();

using var scope = app.Services.CreateAsyncScope();
var dbSeeder = scope.ServiceProvider.GetRequiredService<AuthDbSeeder>();
await dbSeeder.SeedAsync();
app.Run();

public class ProblemDetailsResultFactory : IFluentValidationAutoValidationResultFactory
{
    public IResult CreateResult(
        EndpointFilterInvocationContext context,
        FluentValidation.Results.ValidationResult validationResult
    )
    {
        var problemDetails = new HttpValidationProblemDetails(
            validationResult.ToValidationProblemErrors()
        )
        {
            Type = "https://tools.ietf.org/html/rfc4918#section-11.2",
            Title = "Unprocessable Entity",
            Status = 422,
        };
        return TypedResults.Problem(problemDetails);
    }
}












































// record WeatherForecast(DateOnly Date, int TemperatureC, string? Summary)
// {
//     public int TemperatureF => 32 + (int)(TemperatureC / 0.5556);
// }
//
//
// var summaries = new[]
// {
//     "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
// };
//
// app.MapGet("/weatherforecast", () =>
//     {
//         var forecast = Enumerable.Range(1, 5).Select(index =>
//                 new WeatherForecast
//                 (
//                     DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
//                     Random.Shared.Next(-20, 55),
//                     summaries[Random.Shared.Next(summaries.Length)]
//                 ))
//             .ToArray();
//         return forecast;
//     })
//     .WithName("GetWeatherForecast")
//     .WithOpenApi();
