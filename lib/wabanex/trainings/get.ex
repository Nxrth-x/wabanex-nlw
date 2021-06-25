defmodule Wabanex.Trainings.Get do
  alias Wabanex.{Repo, Training}
  alias Ecto.UUID

  def call(uuid) do
    uuid
    |> UUID.cast()
    |> handle_response()
  end

  defp handle_response(:error), do: {:error, "UUID is invalid"}

  defp handle_response({:ok, uuid}) do
    case Repo.get(Training, uuid) do
      nil -> {:error, "Training not found"}
      training -> {:ok, training}
    end
  end
end
