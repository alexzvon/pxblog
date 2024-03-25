defmodule Pxblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string, null: false
      add :email, :string, null: false
      add :phone, :string, null: false
      add :email_verified_at, :naive_datetime
      add :phone_verified_at, :naive_datetime
      add :password, :string, null: false
      add :token, :string
      add :role, :string, default: "guest"
      add :is_active, :boolean, default: true
      add :person_id, references(:persons)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:phone])
    create unique_index(:users, [:email])
  end
end
