using Rest_API.Data.Entities;

namespace Rest_API;

public static class LandlordRoles
{
    public const string Admin = nameof(Admin);
    public const string Landlord = nameof(Landlord);

    public const string Simple = nameof(Simple);

    public static readonly IReadOnlyCollection<string> All = new[] { Admin, Landlord, Simple };
}
