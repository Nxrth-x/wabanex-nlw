defmodule Wabanex.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.Training

  # Indíca para o Ecto que o UUID deve ser gerado automaticamente
  @primary_key {:id, :binary_id, autogenerate: true}

  @fields [:email, :name, :password]

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    has_one :training, Training

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    # Valida o tamanho mínimo para a senha
    |> validate_length(:password, min: 6)
    # Valida o tamanho mínimo para o nome
    |> validate_length(:name, min: 2)
    # Valida a expressão regular para o email
    |> validate_format(:email, ~r/@/)
    # Valida se o e-mail é único
    |> unique_constraint([:email])
  end
end
