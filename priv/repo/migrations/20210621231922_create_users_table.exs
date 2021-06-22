defmodule Wabanex.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    # Criação da tabela
    create table(:users) do
      add :email, :string
      add :name, :string
      add :password, :string

      timestamps()
    end

    # Criação do índice
    create unique_index(:users, [:email])
  end
end
