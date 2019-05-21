
defmodule StackoverflowCloneA.Controller.Answer.Index do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Error.ResourceNotFoundError


  def index(%Antikythera.Conn{request: %Antikythera.Request{query_params: query_params}} = conn) do
    #ここまでで返ってきたもの　%{"question_id" => "12345678", "user_id" => "98765"}
    
    # クライアントが渡してくる情報によって分岐をしている
    # 分岐をさせてクエリ？を作っている　検索にかける制限の部分を作っている
    query = case query_params do
      %{"question_id" => question_id, "user_id" => user_id} -> %{"data.user_id": user_id, "data.question_id": question_id}
      %{"user_id" => user_id}                               -> %{"data.user_id": user_id}
      %{"question_id" => question_id}                       -> %{"data.question_id": question_id}
      _                                                     -> %{}
    end
    
    # 作ったクエリをdodaiに渡す準備？
    query2 = %Dodai.RetrieveDedicatedDataEntityListRequestQuery{
      query: query,
      sort:  %{"_id" => 1},
    }
    case retreave_answer(conn.context, query2) do
      # %Dodai.RetrieveDedicatedDataEntityListSuccess{body: docs} = res これと同じ？
      # docsにはresが入っている
      %Dodai.RetrieveDedicatedDataEntityListSuccess{body: docs} ->
        # IO.inspect docs
        # docsの中身と求めるresponseの形が違うので変換が必要
        # docはもう持っているからそれを求めるレスポンスの形に入れれば良いのでは？
        Conn.json(conn, 200, docs)
      %Dodai.ResourceNotFound{} ->
        ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
  end

  def retreave_answer(context, query) do
    # dodaiにリクエストするためには何が必要？それの準備
    req = Dodai.RetrieveDedicatedDataEntityListRequest.new(SD.default_group_id(), "Answer", SD.root_key(), query)
      # 実行
     Sazabi.G2gClient.send(context, SD.app_id(), req)
  end
end
