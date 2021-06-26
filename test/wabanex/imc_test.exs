defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "when the file exists, returns the calculated data" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Diego" => 23.04002019946976,
           "Eder" => 22.22222222222222,
           "Gabul" => 22.857142857142858,
           "Rafael" => 24.897060231734173
         }}

      assert response == expected_response
    end

    test "when the file does not exist, returns an error" do
      params = %{"filename" => "hello.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "File doesn't exist"}

      assert response == expected_response
    end
  end
end
