

defmodule StackoverflowCloneA.Controller.Question.Create do
  use StackoverflowCloneA.Controller.Application
  alias Sazabi.G2gClient
  alias StackoverflowCloneA.Dodai, as: SD
#  alias StackoverflowCloneA.Error.BadRequestError
  alias StackoverflowCloneA.Controller.Question.{Helper}

  # plugを使うことを宣言
  # 中身はfetch_me.exをみる
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []

  # クライアントが私したものをAntikytheraが受け取っている
  def create(%Antikythera.Conn{assigns: %{me: me}, request: request} = conn) do
        
        data = %{
          "user_id" => me["_id"],
          "title" => request.body["title"],
          "body" => request.body["body"],
          "like_voter_ids"    => [],
          "dislike_voter_ids" => [],
          "comments"          => [], 
        }

        req_body = %Dodai.CreateDedicatedDataEntityRequestBody{data: data}
        req = Dodai.CreateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), SD.root_key(), req_body)
        %Dodai.CreateDedicatedDataEntitySuccess{body: res_body} = G2gClient.send(conn.context, SD.app_id(), req)
        IO.inspect res_body
        Conn.json(conn, 201, Helper.to_response_body(res_body))
  end
end