defmodule StackoverflowCloneA.Controller.Question.Show do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Error.ResourceNotFoundError
  alias StackoverflowCloneA.Controller.Question.Helper

  def show( %Antikythera.Conn{ request: %Antikythera.Request{ path_matches: %{id: id} }} = conn) do
    # Implement me
    # IO.inspect conn
    # IO.inspect id

    req = Dodai.RetrieveDedicatedDataEntityRequest.new(SD.default_group_id(), "Question", id, SD.root_key())
    res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
    # IO.inspect res
  
    case res do
      %Dodai.RetrieveDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
      %Dodai.ResourceNotFound{}                            -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end

  end
end
