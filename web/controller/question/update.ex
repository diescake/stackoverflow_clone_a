defmodule StackoverflowCloneA.Controller.Question.Update do
  use StackoverflowCloneA.Controller.Application

  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []


  #実行サンプル
  # curl -X PUT -H "authorization: H6EOMlPraoSmB5fSNjjV" -H "Content-type: application/json" -d '{"title":"hoge_t" ,"body":"hoge_b"}' http://stackoverflow-clone-a.localhost:8080/v1/question/5cde04176e1dc843f6aa53ae | jq

  def update(%Antikythera.Conn{assigns: %{me: _me}, request: request} = conn) do
    #更新するデータ
    body = request.body

    #更新する質問(quetion)のid
    id = request.path_matches.id
    
    IO.inspect body
    IO.inspect id


    req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => body}}
    req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), id, SD.root_key(), req_body)

    res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)

    IO.inspect "/////////////////"
    IO.inspect res

    # %Dodai.ResourceNotFound
    case res do
      %Dodai.UpdateDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
      %Dodai.ResourceNotFound{} -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end


  end
end
