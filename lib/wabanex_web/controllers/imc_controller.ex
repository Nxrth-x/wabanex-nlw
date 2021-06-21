defmodule WabanexWeb.IMCController do
  use WabanexWeb, :controller
  alias Wabanex.IMC

  def index(conn, params) do
    params
    |> IMC.calculate()
    |> handle_response(conn)
  end

  defp handle_response({:ok, data}, conn), do: render_json(data, :ok, conn)
  defp handle_response({:error, data}, conn), do: render_json(data, :bad_request, conn)

  defp render_json(data, status, conn) do
    conn
    |> put_status(status)
    |> json(%{result: data})
  end
end
