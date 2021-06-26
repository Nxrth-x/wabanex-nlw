defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true
  alias Wabanex.User

  describe "changeset/1" do
    test "when all params are valid, it returns a valid changeset" do
      params = %{name: "Eder", email: "eder@teste.com", password: "senha123"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{name: "Eder", email: "eder@teste.com", password: "senha123"},
               errors: []
             } = response
    end

    test "when all params are valid, it returns an invalid changeset" do
      params = %{name: "d", email: "edrteste.com", passsword: "sena"}

      response = User.changeset(params)

      assert errors_on(response) == %{
               email: ["has invalid format"],
               name: ["should be at least 2 character(s)"],
               password: ["can't be blank"]
             }
    end
  end
end
