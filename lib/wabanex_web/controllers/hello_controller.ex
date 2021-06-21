defmodule WabanexWeb.HelloController do
  use WabanexWeb, :controller

  def index(conn, params) do
    params
    |> handle_request()
    |> handle_response(conn)
  end

  defp handle_request(%{"name" => name}), do: {:ok, "Hello, #{name}!"}
  defp handle_request(_params), do: {:error, "A name was not provided"}

  defp handle_response({:ok, data}, conn), do: render_json(data, :ok, conn)
  defp handle_response({:error, data}, conn), do: render_json(data, :bad_request, conn)

  defp render_json(data, status, conn) do
    conn
    |> put_status(status)
    |> json(%{result: data})
  end
end
