defmodule StackoverflowCloneA.Controller.Question.Show do
  use StackoverflowCloneA.Controller.Application
  #  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  # def show(_conn) do
  #   # Implement me
  # end

  def show(%Antikythera.Conn{request: %Antikythera.Request{path_matches: %{id: id}}} = conn) do
    IO.inspect conn
    IO.inspect id

    req = Dodai.RetrieveDedicatedDataEntityRequest.new("g_HtEsAbX7", "Question", id, "rkey_0ywy9jSuXktTvzF")
    # req = Dodai.RetrieveDedicatedDataEntityRequest.new(
      # StackoverflowCloneA.Dodai.default_group_id()
      # "Question",
      # id,
      # StackoverflowCloneA.Dodai.root_key()
      # )

    res = Sazabi.G2gClient.send(conn.context, "a_BvqzN73e", req)
    IO.inspect res
    res = Sazabi.G2gClient.send(conn.context, StackoverflowCloneA.Dodai.app_id(), req)
    case res do
      %Dodai.RetrieveDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
      %Dodai.ResourceNotFound{}                            -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
  end
end
