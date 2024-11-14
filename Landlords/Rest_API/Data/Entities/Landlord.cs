using System.ComponentModel.DataAnnotations;
using FluentValidation;

namespace Rest_API.Data.Entities;

public class Landlord
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public required string Email { get; set; }
    public required string PhoneNumber { get; set; }
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;

    [Required]
    public required string UserId { get; set; }
    public LandlordRestUser User { get; set; }

    public LandlordDto ToDto()
    {
        return new LandlordDto(Id, Name, Email, PhoneNumber, CreatedAt, UpdatedAt);
    }
}

public record LandlordDto(
    int landlordId,
    String name,
    String email,
    String phone_number,
    DateTimeOffset createdAt,
    DateTimeOffset updatedAt
);

public record CreateLandlordDto(String name, String email, String phone_number)
{
    public class CreateLandlordDtoValidator : AbstractValidator<CreateLandlordDto>
    {
        public CreateLandlordDtoValidator()
        {
            RuleFor(x => x.name).NotEmpty().Length(min: 2, max: 50);
            RuleFor(x => x.email).NotEmpty().Length(min: 5, max: 50);
            RuleFor(x => x.phone_number).NotEmpty().Length(min: 8, max: 50);
        }
    }
}

public record UpdateLandlordDto(String name, String email, String phone_number)
{
    public class UpdateLandlordDtoValidatior : AbstractValidator<UpdateLandlordDto>
    {
        public UpdateLandlordDtoValidatior()
        {
            RuleFor(x => x.name).NotEmpty().Length(min: 2, max: 50);
            RuleFor(x => x.email).NotEmpty().Length(min: 5, max: 50);
            RuleFor(x => x.phone_number).NotEmpty().Length(min: 8, max: 50);
        }
    }
};
