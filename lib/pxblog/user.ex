defmodule Pxblog.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :token, :string
    field :password, :string
    field :role, Ecto.Enum, values: [:admin, :manager, :content, :advertiser, :client, :guest], default: :guest
    field :login, :string
    field :email, :string
    field :phone, :string
    field :email_verified_at, :naive_datetime
    field :phone_verified_at, :naive_datetime
    field :is_active, :boolean, default: true

    belongs_to :persons, Pxblog.Person, foreign_key: :person_id, references: :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:login, :email, :phone, :email_verified_at, :phone_verified_at, :password, :token, :role, :is_active])
    |> validate_required([:login, :email, :phone, :email_verified_at, :phone_verified_at, :password, :token, :role, :is_active])
    |> unique_constraint(:phone)
    |> unique_constraint(:email)
  end
end
