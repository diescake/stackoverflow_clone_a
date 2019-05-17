
defmodule StackoverflowCloneA.Controller.Question.Update do
  use StackoverflowCloneA.Controller.Application
  # alias Sazabi.G2gClient
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Question.Helper
  alias StackoverflowCloneA.Error.{AuthenticationError, ResourceNotFoundError}

  # クライアントリクエストの実行例
  # curl -XPUT -H "authorization: H6EOMlPraoSmB5fSNjjV" -H "Content-type: application/json" -d '{"title":"mytitle","body":"world"}' http://stackoverflow-clone-a.localhost:8080/v1/question/5cde04176e1dc843f6aa53ae | jq
  # authorization = ログインした時のkey? 期限がある　= credential?
  # urlの一番最後にQ_idをかく

  # plugを使うことを宣言
  # 中身はfetch_me.exをみる
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []

  
  def update(%Antikythera.Conn{assigns: %{me: me}, request: %{body: %{"body" => body, "title" => title}, path_matches: %{id: id}} = request} = conn) do
    # IO.inspect request
    IO.inspect [body, title, id]

    # Q_idをDodaiからAntikytheraがもらう
      # Dodaiからもらうために必要なものを準備
    req2 = Dodai.RetrieveDedicatedDataEntityRequest.new("g_HtEsAbX7", "Question", id, "rkey_0ywy9jSuXktTvzF")
      # 実行
    res1 = Sazabi.G2gClient.send(conn.context, "a_BvqzN73e", req2)
    IO.inspect res1

    # Questionの作成者のidを取得する
    q_user_id = res1.body["data"]["user_id"]
    IO.inspect q_user_id
    IO.inspect me

    # meから今ログインしているuserのidを取得する
    id_of_me = me["_id"]

    # 取得したidたちが同じかを比較して、同じなら処理を進める
    if id_of_me == q_user_id do
        #更新するデータ
        body = request.body

        #更新する質問(quetion)のid
        id = request.path_matches.id

        # updateしたい内容を準備
          # 更新したい内容の確定
        req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => body}}
          # dodaiにリクエストするためには何が必要？それの準備
        req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), id, SD.root_key(), req_body)
        # update実行
        res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
        # dodaiから返ってきたものをどのようにクライアントに教えるのか
        case res do
          %Dodai.UpdateDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
          %Dodai.ResourceNotFound{}                          -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
        end
    else
      ErrorJson.json_by_error(conn, AuthenticationError.new())
    end
        
  end
end