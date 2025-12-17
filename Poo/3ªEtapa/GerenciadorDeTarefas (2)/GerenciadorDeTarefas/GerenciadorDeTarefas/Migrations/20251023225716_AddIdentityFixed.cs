using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GerenciadorDeTarefas.Migrations
{
    /// <inheritdoc />
    public partial class AddIdentityFixed : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "a18be9c0-aa65-4af8-bd17-00bd9344e575",
                columns: new[] { "ConcurrencyStamp", "PasswordHash", "SecurityStamp" },
                values: new object[] { "c8554266-b401-4519-9aeb-667a8ef0b0c6", "AQAAAAIAAYagAAAAEHqOZ8vn8Da8NFKMxHtLfUeelk7ncpHmC4HdUBzjQeXzJQTKtT6ddVTgzgzRlWn/Tg==", "SEJYWTDXNBQXGQCHMPKDMQRJXNKQZRQV" });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.UpdateData(
                table: "AspNetUsers",
                keyColumn: "Id",
                keyValue: "a18be9c0-aa65-4af8-bd17-00bd9344e575",
                columns: new[] { "ConcurrencyStamp", "PasswordHash", "SecurityStamp" },
                values: new object[] { "5f746e48-cbc5-4843-9ec8-859531ef079d", "AQAAAAIAAYagAAAAEKZt70PxH1DcfSRPCm3Vz2htwnbS9TVcSftnxxUqKA1PAq06GecV8y6YZ+7wU0/U5w==", "8ab339d3-c660-4409-adc4-96644cd1a0bc" });
        }
    }
}
