defmodule TestUsersRepo do
  alias Wabanex.Users.{Get, Create}

  def insert(params) do
    params
    |> Create.call()
    |> IO.inspect()
  end

  def read(uuid) do
    uuid
    |> Get.call()
    |> IO.inspect()
  end
end

params = %{email: "eder@teste.com", name: "Eder", password: "senha123"}

{:ok, user} = TestUsersRepo.insert(params)

TestUsersRepo.read(user.id)
