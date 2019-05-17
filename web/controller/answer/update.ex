defmodule StackoverflowCloneA.Controller.Answer.Update do
  use StackoverflowCloneA.Controller.Application

  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Answer.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError


  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []

  def update(%Antikythera.Conn{ assigns: %{me: me}, request: request } = conn) do
    # Implement me
    # IO.inspect me
    # IO.inspect request

    #userのid
    user_id = me["_id"]
    #更新する値
    body = request.body
    #更新したい回答id
    ans_id = request.path_matches.id

    # IO.inspect user_id
    # IO.inspect body
    # IO.inspect ans_id

    #1 更新したい回答があるか
    ans_req = Dodai.RetrieveDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), ans_id, SD.root_key())
    ans_res = Sazabi.G2gClient.send(conn.context, SD.app_id(), ans_req)


    case ans_res do
      %Dodai.RetrieveDedicatedDataEntitySuccess{body: doc} -> request_user(doc, conn, body, ans_id, user_id)
      _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end

  end


  # useridの確認
  def request_user(doc, conn, body, ans_id, user_id) do
    doc_user_id = doc["data"]["user_id"]
    
    # IO.inspect doc_user_id
    # IO.inspect user_id
    # IO.inspect body
    # IO.inspect "////////////"

    # ここでuserが一致であるかの確認
    if doc_user_id == user_id do

      req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => body}}

      req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), ans_id, SD.root_key(), req_body)

      IO.inspect "#3"
      
      res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)

      case res do
        %Dodai.UpdateDedicatedDataEntitySuccess{body: dc} -> Conn.json(conn, 200, Helper.to_response_body(dc))
        _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
      end

    else
      ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end



  end
end
