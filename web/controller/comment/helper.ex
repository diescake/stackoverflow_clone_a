use Croma

defmodule StackoverflowCloneA.Controller.Comment.Helper do
  use StackoverflowCloneA.Controller.Application

  # defun to_response_body(doc :: map) :: map do
  #   Map.merge(doc, %{
  #     "id"         => doc["_id"],
  #     "created_at" => doc["createdAt"],
  #   })
  # end

  #時間がないのでなんちゃって実装
  defun to_response_body(doc :: map, id) :: map do
    body = Enum.filter(doc["data"]["comments"], fn(x) -> x["_id"] == id end) |> Enum.at(0)

    %{
      "id" =>  body["_id"],
      "user_id" =>  body["user_id"],
      "body" => body["body"],
      "created_at" => body["created_at"]
    }


  end

end
