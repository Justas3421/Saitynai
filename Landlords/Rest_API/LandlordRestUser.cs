using Microsoft.AspNetCore.Identity;

namespace Rest_API;

public class LandlordRestUser : IdentityUser
{
    public bool ForceRelogin { get; set; }
}
