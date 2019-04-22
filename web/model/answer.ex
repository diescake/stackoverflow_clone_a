use Croma

defmodule StackoverflowCloneA.Model.Answer do
  @moduledoc """
  Answer of StackoverflowCloneA app.
  """

  defmodule Body do
    use Croma.SubtypeOfString, pattern: ~r/\A[\s\S]{1,3000}\z/u
  end

  use AntikytheraAcs.Dodai.Model.Datastore, data_fields: [
    body:        Body,
    user_id:     StackoverflowCloneA.DodaiId,
    question_id: StackoverflowCloneA.DodaiId,
    comments:    StackoverflowCloneA.CommentList,
  ]
end
