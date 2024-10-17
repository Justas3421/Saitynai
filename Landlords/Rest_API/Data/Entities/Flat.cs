using FluentValidation;

namespace Rest_API.Data.Entities;

public class Flat
{
    public int Id { get; set; }
    
    public Building Building { get; set; }
    public string FlatNumber { get; set; }
    public int? NumberOfBedrooms { get; set; }
    public int? NumberOfBathrooms { get; set; }
    public decimal? RentAmount { get; set; }
    public bool IsOccupied { get; set; } = false;
    public string? TenantName { get; set; }
    public DateTimeOffset CreatedAt { get; set; } = DateTimeOffset.UtcNow;
    public DateTimeOffset UpdatedAt { get; set; } = DateTimeOffset.UtcNow;

    public FlatDto toDto()
    {
        return new FlatDto(Id, Building.Id, FlatNumber, NumberOfBedrooms, NumberOfBathrooms, RentAmount,IsOccupied, TenantName, createdAt:CreatedAt, updatedAt:UpdatedAt);
    }
    
}

public record FlatDto(int flatId, int buildingId, String flatNumber, int? numBedrooms,
    int? numBathrooms, decimal? rent, bool isOccupied, String? tenantName,  DateTimeOffset createdAt, DateTimeOffset updatedAt);

public record CreateFlatDto(
    string flatNumber,
    int? numBedrooms,
    int? numBathrooms,
    decimal? rent,
    bool isOccupied,
    String? tenantName)
{
    public class CreateFlatDtoValidator : AbstractValidator<CreateFlatDto>
    {
        public CreateFlatDtoValidator()
        {
            RuleFor(x => x.flatNumber).NotEmpty().Length(2, 50);
            RuleFor(x => x.tenantName).NotEmpty().Length(2, 50);
            // Add a rule that tenantName must be null if isOccupied is false
            RuleFor(x => x.tenantName)
                .Null()
                .When(x => !x.isOccupied)
                .WithMessage("Tenant name must be null when the flat is not occupied.");

            // Optional: Add a rule that tenantName must not be null if isOccupied is true
            RuleFor(x => x.tenantName)
                .NotNull()
                .When(x => x.isOccupied)
                .WithMessage("Tenant name must be provided when the flat is occupied.");
        }
    } 
};

public record UpdateFlatDto(
    string flatNumber,
    int? numBedrooms,
    int? numBathrooms,
    decimal? rent,
    bool isOccupied,
    String? tenant)
{
    public class UpdateFlatDtoValidator : AbstractValidator<UpdateFlatDto>
    {
        public UpdateFlatDtoValidator()
        {
            RuleFor(x => x.flatNumber).NotEmpty().Length(2, 50);
            //RuleFor(x => x.tenant).NotEmpty().Length(2, 50);
            // Add a rule that tenantName must be null if isOccupied is false
            // RuleFor(x => x.tenant)
            //     .Null()
            //     .When(x => !x.isOccupied)
            //     .WithMessage("Tenant name must be null when the flat is not occupied.");
            //
            // // Optional: Add a rule that tenantName must not be null if isOccupied is true
            // RuleFor(x => x.tenant)
            //     .NotNull()
            //     .When(x => x.isOccupied)
            //     .WithMessage("Tenant name must be provided when the flat is occupied.");
        }
    } 
};