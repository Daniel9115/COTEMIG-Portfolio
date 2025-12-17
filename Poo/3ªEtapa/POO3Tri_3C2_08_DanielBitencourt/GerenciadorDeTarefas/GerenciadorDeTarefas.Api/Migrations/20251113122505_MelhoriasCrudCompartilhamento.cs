using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GerenciadorDeTarefas.Migrations
{
    /// <inheritdoc />
    public partial class MelhoriasCrudCompartilhamento : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AlterColumn<string>(
                name: "UsuarioId",
                table: "Tarefas",
                type: "nvarchar(450)",
                maxLength: 450,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<bool>(
                name: "Concluida",
                table: "Tarefas",
                type: "bit",
                nullable: false,
                defaultValue: false,
                oldClrType: typeof(bool),
                oldType: "bit");

            migrationBuilder.AlterColumn<string>(
                name: "UsuarioIdCompartilhado",
                table: "Compartilhamentos",
                type: "nvarchar(450)",
                maxLength: 450,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.CreateIndex(
                name: "IX_Tarefas_UsuarioId",
                table: "Tarefas",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_Tarefas_UsuarioId_Concluida",
                table: "Tarefas",
                columns: new[] { "UsuarioId", "Concluida" });

            migrationBuilder.CreateIndex(
                name: "IX_Compartilhamentos_TarefaId_UsuarioIdCompartilhado",
                table: "Compartilhamentos",
                columns: new[] { "TarefaId", "UsuarioIdCompartilhado" },
                unique: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Compartilhamentos_Tarefas_TarefaId",
                table: "Compartilhamentos",
                column: "TarefaId",
                principalTable: "Tarefas",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Compartilhamentos_Tarefas_TarefaId",
                table: "Compartilhamentos");

            migrationBuilder.DropIndex(
                name: "IX_Tarefas_UsuarioId",
                table: "Tarefas");

            migrationBuilder.DropIndex(
                name: "IX_Tarefas_UsuarioId_Concluida",
                table: "Tarefas");

            migrationBuilder.DropIndex(
                name: "IX_Compartilhamentos_TarefaId_UsuarioIdCompartilhado",
                table: "Compartilhamentos");

            migrationBuilder.AlterColumn<string>(
                name: "UsuarioId",
                table: "Tarefas",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldMaxLength: 450);

            migrationBuilder.AlterColumn<bool>(
                name: "Concluida",
                table: "Tarefas",
                type: "bit",
                nullable: false,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValue: false);

            migrationBuilder.AlterColumn<string>(
                name: "UsuarioIdCompartilhado",
                table: "Compartilhamentos",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldMaxLength: 450);
        }
    }
}
