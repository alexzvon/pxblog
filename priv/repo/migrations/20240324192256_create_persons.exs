defmodule Pxblog.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :fio, :string, null: false
      add :sex, :string, default: "male"
      add :birthday, :naive_datetime
      add :avatar, :string
      add :address, :text
      add :description, :text

      timestamps(type: :utc_datetime)
    end
  end
end
