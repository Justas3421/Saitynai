using FluentValidation;
namespace Rest_API.Data.Entities;

public class Building
{
    public int Id { get; set; }
    public required Landlord Landlord { get; set; }
    public required string Name { get; set; }
    public required string Address { get; set; }
    public required string City { get; set; }
    public required string State { get; set; }
    public required string ZipCode { get; set; }
    public int? NumberOfFloors { get; set; }
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;

    public BuildingDto ToDto()
    {
        return new BuildingDto(Id, Landlord.Id, Name, Address, City, State, ZipCode, NumberOfFloors,
            createdAt: CreatedAt, updatedAt: UpdatedAt);
    }
}


public record BuildingDto(int buildingId, int landlordId, String name, String address,
    String city, String state, String zipCode, int? numFloors,  DateTimeOffset createdAt, DateTimeOffset updatedAt);

public record CreateBuildingDto(
    String name,
    String address,
    String city,
    String state,
    String zipCode,
    int? numFloors)
{
    public class CreateBuildingDtoValidator : AbstractValidator<CreateBuildingDto>
    {
        public CreateBuildingDtoValidator()
        {
            RuleFor(x => x.name).NotEmpty().Length(min:2, max:50);
            RuleFor(x => x.address).NotEmpty().Length(min:5, max:50);
            RuleFor(x => x.city).NotEmpty().Length(min:2, max:50);
            RuleFor(x => x.state).NotEmpty().Length(min:2, max:50);
            RuleFor(x => x.zipCode).NotEmpty().Length(min:5, max:10);
        }
    } 
}

public record UpdateBuildingDto(
    String name,
    String address,
    String city,
    String state,
    String zipCode,
    int? numFloors)
{
    public class UpdateBuildingDtoValidator : AbstractValidator<UpdateBuildingDto>
    {
        public UpdateBuildingDtoValidator()
        {
            RuleFor(x => x.name).NotEmpty().Length(min:2, max:50);
            RuleFor(x => x.address).NotEmpty().Length(min:5, max:50);
            RuleFor(x => x.city).NotEmpty().Length(min:5, max:50);
            RuleFor(x => x.state).NotEmpty().Length(min:2, max:50);
            RuleFor(x => x.zipCode).NotEmpty().Length(min:5, max:10);
        }
    } 
}