defmodule StackoverflowCloneA.Controller.Comment.Create do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper
  alias StackoverflowCloneA.Error.{ResourceNotFoundError}

  # クライアントリクエストの実行例
  # 
  # curl -XPOST -H "authorization: 6iVMcf3x1SzqjFFIQj0Q" -H "Content-type: application/json" -d '{"body":"world"}' http://stackoverflow-clone-a.localhost:8080/v1/question/5ce38a06599107049a26b0f5/comment | jq

  # plugを使うことを宣言
  # 中身はfetch_me.exをみる
  # クライアントからのcurlのauthorizationを元にuserを取得する
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []

  def create(%Antikythera.Conn{assigns: %{me: me}, request: %Antikythera.Request{body: %{"body" => body}, path_info: path_info, path_matches: %{document_id: id}}} = conn) do

    coll = String.capitalize(Enum.at(path_info, 1))

    # Questionの情報をDodaiからAntikytheraがもらう
      # Dodaiからもらうために必要なものを準備
      # Dodai.RetrieveDedicatedDataEntityRequest.new("group_id", "Collection_name", q_id, "rootKey")
    q_req = Dodai.RetrieveDedicatedDataEntityRequest.new("g_HtEsAbX7", coll, id, "rkey_0ywy9jSuXktTvzF")
      # 実行
    q_res = Sazabi.G2gClient.send(conn.context, "a_BvqzN73e", q_req)

    q_res_comment = q_res.body["data"]["comments"]

    random = RandomString.stream(:alphanumeric) |> Enum.take(20) |> List.to_string
    
    comments = [%{
        "_id"         => random,        # 上記の方法でランダムな文字列を生成
        "user_id"    => me["_id"],         # login userの`_id`
        "body"       => body,              # userが指定した値
        "created_at" => me["createdAt"],   # comment作成時の時刻 
    }]

    # 作成したいCommentの内容の確定
    req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => %{"comments" => q_res_comment ++ comments}}}
    # dodaiにリクエストするためには何が必要？それの準備
    req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), coll, id, SD.root_key(), req_body)
    # 実行
    res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
    case res do
      %Dodai.UpdateDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
          %Dodai.ResourceNotFound{}                          -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
  end
end


