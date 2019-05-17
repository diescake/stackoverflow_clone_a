use Croma

defmodule StackoverflowCloneA.Controller.Answer.Helper do
  defmodule Params do
    defmodule Body do
      use Croma.SubtypeOfString, pattern: ~r/\A.{1,100}\z/u
    end
    defmodule Question_id do
      use Croma.SubtypeOfString, pattern: ~r/\A.{1,50}\z/u
    end
  end

  @collection_name "Answer"

  defun collection_name() :: String.t do
    @collection_name
  end

  defun to_response_body(map :: map) :: map do
    Map.fetch!(map, "data") |> Map.put("id", map["_id"])
  end
end
