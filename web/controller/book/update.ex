use Croma

defmodule StackoverflowCloneA.Controller.Book.UpdateRequestBody do
  alias StackoverflowCloneA.Controller.Book.Helper.Params

  use Croma.Struct, fields: [
    title:  Croma.TypeGen.nilable(Params.Title),
    author: Croma.TypeGen.nilable(Params.Author),
  ]
end

defmodule StackoverflowCloneA.Controller.Book.Update do
  use StackoverflowCloneA.Controller.Application
  alias Sazabi.G2gClient
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Error.{BadRequestError, ResourceNotFoundError}
  alias StackoverflowCloneA.Controller.Book.{Helper, UpdateRequestBody}

  defun update(%Conn{request: %Request{path_matches: %{id: id}, body: body}, context: context} = conn) :: Conn.t do
    # 更新したい内容のストラクトを生成して
    case UpdateRequestBody.new(body) do
      {:error, _}      ->
        ErrorJson.json_by_error(conn, BadRequestError.new())
      {:ok, validated} ->
        # そのストラクトをmapに変換　valueがnilのものを排除して新しくmapを作成？更新？
        set_data = Map.from_struct(validated) |> Enum.reject(fn {_, value} -> is_nil(value) end) |> Map.new()
        # updateしたい内容を準備
          # 更新したい内容の確定
        req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => set_data}}
          # dodaiにリクエストするためには何が必要？それの準備
        req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), Helper.collection_name(), id, SD.root_key(), req_body)
        # update実行
        res = G2gClient.send(context, SD.app_id(), req)
        # dodaiから返ってきたものをどのようにクライアントに教えるのか
        case res do
          %Dodai.UpdateDedicatedDataEntitySuccess{body: doc} -> Conn.json(conn, 200, Helper.to_response_body(doc))
          %Dodai.ResourceNotFound{}                          -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
        end
    end
  end
end
