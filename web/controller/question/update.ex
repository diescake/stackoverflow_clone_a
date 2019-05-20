defmodule StackoverflowCloneA.Controller.Question.Update do
  use StackoverflowCloneA.Controller.Application

  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []


  #実行サンプル
  # curl -X PUT -H "authorization: H6EOMlPraoSmB5fSNjjV" -H "Content-type: application/json" -d '{"title":"hoge_t" ,"body":"hoge_b"}' http://stackoverflow-clone-a.localhost:8080/v1/question/5cde04176e1dc843f6aa53ae | jq

  def update(%Antikythera.Conn{assigns: %{me: me}, request: request} = conn) do

    #ユーザーのID
    user_id = me["_id"]
    # IO.inspect user_id

    #quetionのID
    quetion_id = request.path_matches.id
    # IO.inspect quetion_id

    #1 更新する質問があるか確認
    quetion_req = Dodai.RetrieveDedicatedDataEntityRequest.new(SD.default_group_id(), "Question", quetion_id, SD.root_key())
    quetion_res = Sazabi.G2gClient.send(conn.context, SD.app_id(), quetion_req)
    # IO.inspect quetion_res

    case quetion_res do
      %Dodai.RetrieveDedicatedDataEntitySuccess{body: doc} -> request_user(doc, conn, request.body, request.path_matches.id, user_id)
      _  -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
    
  end


  #2 更新する人が同一であるかの確認
  def request_user(doc, conn, body, quetion_id, user_id) do
    #質問されたユーザーのID
    request_userid = doc["data"]["user_id"]
    

    # IO.inspect "/////////"
    # IO.inspect conn
    # IO.inspect body
    # IO.inspect quetion_id
    # IO.inspect user_id


    #ここで比較
    if request_userid == user_id do
      req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => body}}
      req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), quetion_id, SD.root_key(), req_body)

      res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)

      #更新
      case res do
        %Dodai.UpdateDedicatedDataEntitySuccess{body: dc} -> Conn.json(conn, 200, Helper.to_response_body(dc))
        _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
      end
    
      
    else
      ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end


  end
end
