using Microsoft.AspNetCore.Identity;

namespace Rest_API;

public class AuthDbSeeder
{
    private readonly UserManager<LandlordRestUser> _userManager;
    private readonly RoleManager<IdentityRole> _roleManager;

    public AuthDbSeeder(
        UserManager<LandlordRestUser> userManager,
        RoleManager<IdentityRole> roleManager
    )
    {
        _userManager = userManager;
        _roleManager = roleManager;
    }

    public async Task SeedAsync()
    {
        await AddDefaultRoles();
        await AddAdminUser();
    }

    private async Task AddAdminUser()
    {
        var newAdminUser = new LandlordRestUser { UserName = "admin", Email = "admin@gmail.com" };

        var existingAdminUser = await _userManager.FindByNameAsync(newAdminUser.UserName);
        if (existingAdminUser == null)
        {
            var createAdminUserResult = await _userManager.CreateAsync(newAdminUser, "Asd123*");
            if (createAdminUserResult.Succeeded)
            {
                await _userManager.AddToRolesAsync(newAdminUser, LandlordRoles.All);
            }
        }
    }

    private async Task AddDefaultRoles()
    {
        foreach (var role in LandlordRoles.All)
        {
            var roleExists = await _roleManager.RoleExistsAsync(role);
            if (!roleExists)
            {
                await _roleManager.CreateAsync(new IdentityRole(role));
            }
        }
    }
}
