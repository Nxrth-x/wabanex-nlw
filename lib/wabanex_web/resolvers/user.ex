defmodule WabanexWeb.Resolvers.User do
  alias Wabanex.Users

  # Resolver que interage com o banco
  def get(%{id: user_id}, _context), do: Users.Get.call(user_id)

  def create(%{input: params}, _context), do: Users.Create.call(params)
end
