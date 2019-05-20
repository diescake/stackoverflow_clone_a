
defmodule StackoverflowCloneA.Controller.Answer.Show do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Answer.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  def show(%Conn{request: %Request{path_matches: %{id: id}}} = conn) do
    req = Dodai.RetrieveDedicatedDataEntityRequest.new(SD.default_group_id(), "Answer", id, SD.root_key())

    res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
    case res do
      %Dodai.RetrieveDedicatedDataEntitySuccess{body: body} -> Conn.json(conn, 200, Helper.to_response_body(body))
      %Dodai.ResourceNotFound{}                             -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
  end
end
