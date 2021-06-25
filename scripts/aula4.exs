defmodule TestTrainingsRepo do
  alias Wabanex.Trainings.Create

  def main(params) do
    params
    |> Create.call()
    |> IO.inspect()
  end
end

params = %{
  user_id: "07a91c22-d403-4188-ad6d-cb7491bbb769",
  start_date: "2021-06-22",
  end_date: "2021-07-22",
  exercises: [
    %{
      name: "Triceps banco",
      youtube_video_url: "https://google.com",
      protocol_description: "Regular",
      repetitions: "3x12"
    },
    %{
      name: "Triceps corda",
      youtube_video_url: "https://google.com",
      protocol_description: "Regular",
      repetitions: "4x8"
    }
  ]
}

TestTrainingsRepo.main(params)
