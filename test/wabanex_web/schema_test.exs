defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  @url "/api/graphql"

  describe "users query" do
    test "when a valid id is given, returns the user", %{conn: conn} do
      params = %{email: "eder@mail.com", name: "Eder", password: "senha123"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        query {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post(@url, %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "eder@mail.com",
            "id" => user_id,
            "name" => "Eder"
          }
        }
      }

      assert response == expected_response
    end

    test "when an invalid id is given, returns an error", %{conn: conn} do
      # Creates the user
      params = %{email: "eder@mail.com", name: "Eder", password: "senha123"}

      Create.call(params)

      # Invalid UUID
      user_id = "banana"

      # GraphQL query
      query = """
        query {
          getUser(id: "#{user_id}") {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post(@url, %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "errors" => [
          %{
            "locations" => [%{"column" => 13, "line" => 2}],
            "message" => "Argument \"id\" has invalid value \"banana\"."
          }
        ]
      }

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "when all the params are valid, creates the user", %{conn: conn} do
      mutation = """
      mutation {
        createUser(input: {
          name: "Eder Lima"
          email: "eder@teste.com"
          password: "senha123"
        }) {
          name
          email
        }
      }
      """

      response =
        conn
        |> post(@url, %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"createUser" => %{"email" => "eder@teste.com", "name" => "Eder Lima"}}
      }

      assert response == expected_response
    end

    test "when an invalid parameter is passed, returns an error", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "E"
            email: "ederteste.com"
            password: "s11"
          }) {
            name
            email
          }
        }
      """

      response =
        conn
        |> post(@url, %{query: mutation})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"createUser" => nil},
        "errors" => [
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "email has invalid format",
            "path" => ["createUser"]
          },
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "name should be at least 2 character(s)",
            "path" => ["createUser"]
          },
          %{
            "locations" => [%{"column" => 5, "line" => 2}],
            "message" => "password should be at least 6 character(s)",
            "path" => ["createUser"]
          }
        ]
      }

      assert response == expected_response
    end
  end
end
