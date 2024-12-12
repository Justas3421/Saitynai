using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.EntityFrameworkCore;
using Rest_API.Data.Entities;
using SharpGrip.FluentValidation.AutoValidation.Endpoints.Extensions;

namespace Rest_API;

public static class Endpoints
{
    public static void AddLandlordApiEndpoints(this WebApplication app)
    {
        var landlordsGroup = app.MapGroup("/api").AddFluentValidationAutoValidation();

        landlordsGroup.MapGet(
            "/landlords",
            async (LandlordDbContext dbContext) =>
            {
                return (await dbContext.Landlords.ToListAsync()).Select(landlord =>
                    landlord.ToDto()
                );
            }
        );

        landlordsGroup.MapGet(
            "/landlords/{landlordId}",
            async (int landlordId, LandlordDbContext dbContext) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                return landlord == null ? Results.NotFound() : TypedResults.Ok(landlord.ToDto());
            }
        );

        landlordsGroup.MapPost(
            "/landlords",
            async (CreateLandlordDto dto, HttpContext httpContext, LandlordDbContext dbContext) =>
            {
                foreach (var claim in httpContext.User.Claims)
                {
                    Console.WriteLine($"{claim.Type}: {claim.Value}");
                }
                var landlord = new Landlord
                {
                    Name = dto.name,
                    Email = dto.email,
                    PhoneNumber = dto.phone_number,
                    UserId = httpContext.User.FindFirstValue(ClaimTypes.NameIdentifier),
                };
                dbContext.Landlords.Add(landlord);
                await dbContext.SaveChangesAsync();
                return TypedResults.Created($"api/landlords/{landlord.Id}", landlord.ToDto());
            }
        );

        landlordsGroup.MapPut(
            "/landlords/{landlordId}",
            async (
                int landlordId,
                UpdateLandlordDto dto,
                HttpContext httpContext,
                LandlordDbContext dbContext
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }

                landlord.Name = dto.name;
                landlord.Email = dto.email;
                landlord.PhoneNumber = dto.phone_number;
                landlord.UpdatedAt = DateTimeOffset.UtcNow;
                await dbContext.SaveChangesAsync();
                return TypedResults.Ok(landlord.ToDto());
            }
        );

        landlordsGroup.MapDelete(
            "/landlords/{landlordId}",
            async (int landlordId, HttpContext httpContext, LandlordDbContext dbContext) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                dbContext.Landlords.Remove(landlord);
                await dbContext.SaveChangesAsync();
                return TypedResults.NoContent();
            }
        );
    }

    public static void AddBuildingsApiEndpoints(this WebApplication app)
    {
        var buildingsGroup = app.MapGroup("/api/landlords/{landlordId}")
            .AddFluentValidationAutoValidation();

        buildingsGroup.MapGet(
            "buildings",
            async (int landlordId, LandlordDbContext dbContext) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);

                if (landlord == null)
                {
                    return Results.NotFound();
                }

                var buildings = await dbContext
                    .Buildings.Where(b => b.Landlord.Id == landlord.Id)
                    .ToListAsync();

                var buildingDtos = buildings.Select(building => building.ToDto());

                return Results.Ok(buildingDtos);
            }
        );

        buildingsGroup.MapGet(
            "buildings/{buildingId}",
            async (int landlordId, int buildingId, LandlordDbContext dbContext) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }

                return TypedResults.Ok(building.ToDto());
            }
        );

        buildingsGroup.MapPost(
            "buildings",
            async (
                int landlordId,
                LandlordDbContext dbContext,
                HttpContext httpContext,
                CreateBuildingDto dto
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }

                var building = new Building
                {
                    Landlord = landlord,
                    Name = dto.name,
                    Address = dto.address,
                    City = dto.city,
                    State = dto.state,
                    ZipCode = dto.zipCode,
                    NumberOfFloors = dto.numFloors,
                    UserId = landlord.UserId,
                };
                dbContext.Buildings.Add(building);
                await dbContext.SaveChangesAsync();
                return TypedResults.Created(
                    $"api/landlords/{landlord.Id}/buildings/{building.Id}",
                    building.ToDto()
                );
            }
        );

        buildingsGroup.MapPut(
            "buildings/{buildingId}",
            async (
                int landlordId,
                int buildingId,
                HttpContext httpContext,
                LandlordDbContext dbContext,
                UpdateBuildingDto dto
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }

                building.Name = dto.name;
                building.Address = dto.address;
                building.City = dto.city;
                building.State = dto.state;
                building.ZipCode = dto.zipCode;
                building.NumberOfFloors = dto.numFloors;
                building.UpdatedAt = DateTimeOffset.UtcNow;
                await dbContext.SaveChangesAsync();
                return TypedResults.Ok(landlord.ToDto());
            }
        );

        buildingsGroup.MapDelete(
            "buildings/{buildingId}",
            async (
                int landlordId,
                int buildingId,
                HttpContext httpContext,
                LandlordDbContext dbContext
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }
                dbContext.Buildings.Remove(building);
                await dbContext.SaveChangesAsync();
                return TypedResults.NoContent();
            }
        );
    }

    public static void AddFlatsApiEndpoints(this WebApplication app)
    {
        var flatsGroup = app.MapGroup("/api/landlords/{landlordId}/buildings/{buildingId}")
            .AddFluentValidationAutoValidation();

        flatsGroup.MapGet(
            "flats",
            async (int landlordId, int buildingId, LandlordDbContext dbContext) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }

                var flatsDto = (await dbContext.Flats.ToListAsync()).Select(flat => flat.toDto());
                flatsDto = flatsDto.Where((e) => e.buildingId == buildingId);
                return TypedResults.Ok(flatsDto);
            }
        );

        flatsGroup.MapGet(
            "flats/{flatId}",
            async (int landlordId, int buildingId, int flatId, LandlordDbContext dbContext) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }
                var flat = await dbContext.Flats.FindAsync(flatId);
                return flat == null ? Results.NotFound() : TypedResults.Ok(flat.toDto());
            }
        );

        flatsGroup.MapPost(
            "flats",
            async (
                int buildingId,
                int landlordId,
                LandlordDbContext dbContext,
                HttpContext httpContext,
                CreateFlatDto dto
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }

                var flat = new Flat
                {
                    Building = building,
                    FlatNumber = dto.flatNumber,
                    NumberOfBedrooms = dto.numBedrooms,
                    NumberOfBathrooms = dto.numBathrooms,
                    RentAmount = dto.rent,
                    IsOccupied = dto.isOccupied,
                    TenantName = dto.tenantName,
                    CreatedAt = DateTimeOffset.UtcNow,
                    UpdatedAt = DateTimeOffset.UtcNow,
                    UserId = landlord.UserId,
                };
                dbContext.Flats.Add(flat);
                await dbContext.SaveChangesAsync();
                return TypedResults.Created(
                    $"api/landlords/{landlord.Id}/buildings/{building.Id}/flats/{flat.Id}",
                    flat.toDto()
                );
            }
        );

        flatsGroup.MapPut(
            "flats/{flatId}",
            async (
                int landlordId,
                int buildingId,
                int flatId,
                HttpContext httpContext,
                LandlordDbContext dbContext,
                UpdateFlatDto dto
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }
                var flat = await dbContext.Flats.FindAsync(flatId);
                if (
                    flat == null
                    || flat.Building == null
                    || flat.Building.Id != buildingId
                    || flat.Building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }

                flat.FlatNumber = dto.flatNumber;
                flat.NumberOfBedrooms = dto.numBedrooms;
                flat.NumberOfBathrooms = dto.numBathrooms;
                flat.RentAmount = dto.rent;
                flat.IsOccupied = dto.isOccupied;
                flat.TenantName = dto.tenant;
                flat.UpdatedAt = DateTimeOffset.UtcNow;
                await dbContext.SaveChangesAsync();
                return TypedResults.Ok(flat.toDto());
            }
        );

        flatsGroup.MapDelete(
            "flats/{flatId}",
            async (
                int landlordId,
                int buildingId,
                HttpContext httpContext,
                int flatId,
                LandlordDbContext dbContext
            ) =>
            {
                var landlord = await dbContext.Landlords.FindAsync(landlordId);
                if (landlord == null)
                {
                    return Results.NotFound();
                }
                var building = await dbContext.Buildings.FindAsync(buildingId);
                if (
                    building == null
                    || building.Landlord == null
                    || building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }
                var flat = await dbContext.Flats.FindAsync(flatId);
                if (
                    flat == null
                    || flat.Building == null
                    || flat.Building.Id != buildingId
                    || flat.Building.Landlord.Id != landlordId
                )
                {
                    return Results.NotFound();
                }

                dbContext.Flats.Remove(flat);
                await dbContext.SaveChangesAsync();
                return TypedResults.Ok(flat.toDto());
            }
        );
    }
}
