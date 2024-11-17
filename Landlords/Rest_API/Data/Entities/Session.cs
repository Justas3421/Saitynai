using System.ComponentModel.DataAnnotations;

namespace Rest_API;

public class Session
{
    public Guid Id { get; set; }

    public string LastRefreshToken { get; set; }

    public DateTimeOffset InitiatedAt { get; set; }

    public DateTimeOffset ExpiresAt { get; set; }

    public bool IsRevoked { get; set; }

    [Required]
    public required string UserId { get; set; }

    public LandlordRestUser User { get; set; }
}