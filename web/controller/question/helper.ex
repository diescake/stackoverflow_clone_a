use Croma

defmodule StackoverflowCloneA.Controller.Question.Helper do
  use StackoverflowCloneA.Controller.Application

  @collection_name "Question"

  defun collection_name() :: String.t do
    @collection_name
  end

  defun to_response_body(doc :: map) :: map do
    Map.merge(doc["data"], %{
      "id"         => doc["_id"],
      "created_at" => doc["createdAt"],
    })
  end
end
