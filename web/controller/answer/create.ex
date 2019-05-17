defmodule StackoverflowCloneA.Controller.Answer.Create do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Answer.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []
  

  def create(%Antikythera.Conn{ assigns: %{me: me}, request: %Antikythera.Request{ body: body} }  = conn) do
    IO.inspect conn
    IO.inspect body
    IO.inspect me

    #idの取得
    user_id = me["_id"]

    IO.inspect user_id


    #questionがあるか確認
    quetion_req = Dodai.RetrieveDedicatedDataEntityRequest.new(SD.default_group_id(), "Question", body["question_id"], SD.root_key())
    quetion_res = Sazabi.G2gClient.send(conn.context, SD.app_id(), quetion_req)


    case quetion_res do
      %Dodai.RetrieveDedicatedDataEntitySuccess{} -> request_anser(conn, user_id, body)
      _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
  end



  #回答の作成
  def request_anser(conn, id, body) do
    IO.inspect conn
    IO.inspect id
    IO.inspect body

    #dataの作成
    data = %{
      "user_id"     => id,
      "question_id" => body["question_id"],
      "body"        => body["body"],
      "comments"    => []
    }

    # #res res
    req_body = %Dodai.CreateDedicatedDataEntityRequestBody{data: data}
    req = Dodai.CreateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), SD.root_key(), req_body)

    res = Sazabi.G2gClient.send(conn.context, SD.app_id(), req)

    case res do
      %Dodai.CreateDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
      _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
  end

end
