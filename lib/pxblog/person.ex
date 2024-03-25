defmodule Pxblog.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "persons" do
    field :address, :string
    field :description, :string
    field :fio, :string
    field :sex, Ecto.Enum, values: [:male, :female], default: :male
    field :birthday, :naive_datetime
    field :avatar, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:fio, :sex, :birthday, :avatar, :address, :description])
    |> validate_required([:fio, :sex, :birthday, :avatar, :address, :description])
  end
end
