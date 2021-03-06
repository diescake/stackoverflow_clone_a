defmodule StackoverflowCloneA.Controller.Question.Index do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper

  def index(%Antikythera.Conn{ request: %Antikythera.Request{query_params: params} } = conn) do

    # IO.inspect params

    data_params = Enum.reject(params, fn {_, value} -> is_nil(value) end)
              |> Enum.map(fn {k, v} -> {"data.#{k}", v} end)
              |> Map.new()

    query = %Dodai.RetrieveDedicatedDataEntityListRequestQuery{
      query: data_params,
      sort:  %{"_id" => 1},
    }

    req = Dodai.RetrieveDedicatedDataEntityListRequest.new(SD.default_group_id(), Helper.collection_name(), SD.root_key(), query)
    %Dodai.RetrieveDedicatedDataEntityListSuccess{body: docs} = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)

    Conn.json(conn, 200, Enum.map(docs, &Helper.to_response_body(&1)))
  end
end
