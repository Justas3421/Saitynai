using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace Rest_API.Migrations
{
    /// <inheritdoc />
    public partial class identity : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "UserId",
                table: "Landlords",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "TenantName",
                table: "Flats",
                type: "text",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "text");

            migrationBuilder.AddColumn<string>(
                name: "UserId",
                table: "Flats",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "UserId",
                table: "Buildings",
                type: "text",
                nullable: false,
                defaultValue: "");

            migrationBuilder.CreateTable(
                name: "LandlordRestUser",
                columns: table => new
                {
                    Id = table.Column<string>(type: "text", nullable: false),
                    ForceRelogin = table.Column<bool>(type: "boolean", nullable: false),
                    UserName = table.Column<string>(type: "text", nullable: true),
                    NormalizedUserName = table.Column<string>(type: "text", nullable: true),
                    Email = table.Column<string>(type: "text", nullable: true),
                    NormalizedEmail = table.Column<string>(type: "text", nullable: true),
                    EmailConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    PasswordHash = table.Column<string>(type: "text", nullable: true),
                    SecurityStamp = table.Column<string>(type: "text", nullable: true),
                    ConcurrencyStamp = table.Column<string>(type: "text", nullable: true),
                    PhoneNumber = table.Column<string>(type: "text", nullable: true),
                    PhoneNumberConfirmed = table.Column<bool>(type: "boolean", nullable: false),
                    TwoFactorEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    LockoutEnd = table.Column<DateTimeOffset>(type: "timestamp with time zone", nullable: true),
                    LockoutEnabled = table.Column<bool>(type: "boolean", nullable: false),
                    AccessFailedCount = table.Column<int>(type: "integer", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LandlordRestUser", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Landlords_UserId",
                table: "Landlords",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Flats_UserId",
                table: "Flats",
                column: "UserId");

            migrationBuilder.CreateIndex(
                name: "IX_Buildings_UserId",
                table: "Buildings",
                column: "UserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Buildings_LandlordRestUser_UserId",
                table: "Buildings",
                column: "UserId",
                principalTable: "LandlordRestUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Flats_LandlordRestUser_UserId",
                table: "Flats",
                column: "UserId",
                principalTable: "LandlordRestUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Landlords_LandlordRestUser_UserId",
                table: "Landlords",
                column: "UserId",
                principalTable: "LandlordRestUser",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Buildings_LandlordRestUser_UserId",
                table: "Buildings");

            migrationBuilder.DropForeignKey(
                name: "FK_Flats_LandlordRestUser_UserId",
                table: "Flats");

            migrationBuilder.DropForeignKey(
                name: "FK_Landlords_LandlordRestUser_UserId",
                table: "Landlords");

            migrationBuilder.DropTable(
                name: "LandlordRestUser");

            migrationBuilder.DropIndex(
                name: "IX_Landlords_UserId",
                table: "Landlords");

            migrationBuilder.DropIndex(
                name: "IX_Flats_UserId",
                table: "Flats");

            migrationBuilder.DropIndex(
                name: "IX_Buildings_UserId",
                table: "Buildings");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Landlords");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Flats");

            migrationBuilder.DropColumn(
                name: "UserId",
                table: "Buildings");

            migrationBuilder.AlterColumn<string>(
                name: "TenantName",
                table: "Flats",
                type: "text",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "text",
                oldNullable: true);
        }
    }
}
