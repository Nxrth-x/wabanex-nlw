defmodule TestImcController do
  alias Wabanex.IMC

  def main(filename \\ "") do
    %{"filename" => filename}
    |> IMC.calculate()
  end
end

IO.inspect(TestImcController.main())
IO.inspect(TestImcController.main("hello"))
IO.inspect(TestImcController.main("students.csv"))
