defmodule StackoverflowCloneA.Controller.Question.Create do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []

  #実行サンプル
  # curl -XPOST -H "authorization: H6EOMlPraoSmB5fSNjjV" -H "Content-type: application/json" -d '{"title":"mytitle","body":"world"}' http://stackoverflow-clone-a.localhost:8080/v1/question | jq
  def create(%Antikythera.Conn{assigns: %{me: me}, request: request} = conn) do
    
    #ここでdataをつくる
    data = %{
      "user_id" => me["_id"],
      "title" => request.body["title"],
      "body" => request.body["body"],
      "like_voter_ids"    => [],
      "dislike_voter_ids" => [],
      "comments"          => [], 
    }

    # resとreqを作る
    req_body = %Dodai.CreateDedicatedDataEntityRequestBody{data: data}
    req = Dodai.CreateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), SD.root_key(), req_body)
    res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)


    # IO.inspect res

    # エラー処理
    case res do
      %Dodai.CreateDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
      %Dodai.ResourceNotFound{}                          -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end


  end
end

