
defmodule StackoverflowCloneA.Controller.Answer.Index do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Answer.Helper

  def index(conn) do
    query = %Dodai.RetrieveDedicatedDataEntityListRequestQuery{
      query: %{},
      sort:  %{"_id" => 1},
    }
    req = Dodai.RetrieveDedicatedDataEntityListRequest.new(SD.default_group_id(), "Answer", SD.root_key(), query)
    %Dodai.RetrieveDedicatedDataEntityListSuccess{body: docs} = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
    res_body = Enum.map(docs, &Helper.to_response_body(&1))
    

    Conn.json(conn, 200, res_body)
  end
end