defmodule StackoverflowCloneA.Controller.Comment.Update do
  use StackoverflowCloneA.Controller.Application
  alias StackoverflowCloneA.Dodai, as: SD
  alias StackoverflowCloneA.Controller.Comment.Helper
  alias StackoverflowCloneA.Error.ResourceNotFoundError

  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []

  def update(%Antikythera.Conn{ request: %Antikythera.Request{body: body, path_info: path_info, path_matches: path_matches} } =  conn) do

    # collectionの抜き出し
    # collectionの頭文字が大文字なのでそのように変換する
    coll = String.capitalize(Enum.at(path_info, 1))
    #que or ansのid
    doc_id = path_matches.document_id
    #commentのid
    comments_id = path_matches.id

    # IO.inspect conn
    # IO.inspect body
    # IO.inspect coll
    # IO.inspect doc_id
    # IO.inspect comments_id
    # IO.inspect "/////////////////"
    

    # ans or quetionがあるか確認
    coll_result = coll_def(conn, coll, doc_id)

    case coll_result do
      %Dodai.RetrieveDedicatedDataEntitySuccess{body: doc} -> 
        comm_result = comm_def(doc["data"]["comments"], comments_id)

        # commnetsの有無
        if Enum.empty?(comm_result) do
          ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
        

        else #commentsがあった場合
          #コメントを全取得してから、特定のコメントを更新後、そのlistを投げる?
          comms = doc["data"]["comments"]

          update_comms = Enum.map(comms, fn(t) ->
            if t["_id"] == comments_id do
              put_in(t, ["body"], body["body"])
            else
              t
            end
          end)

          #コメントのアップデート
          comments_update_result = comments_func(conn, coll, doc_id, update_comms)


          case comments_update_result do
            %Dodai.UpdateDedicatedDataEntitySuccess{body: doc} -> 
              
              Conn.json(conn, 200, Helper.to_response_body(doc, comments_id))

            _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
          end
        end
      
      _ -> ErrorJson.json_by_error(conn, ResourceNotFoundError.new())
    end
    
  end

  # ans or quetionがあるかの確認をする関数
  def coll_def(conn, coll, id) do
    req = Dodai.RetrieveDedicatedDataEntityRequest.new(SD.default_group_id(), coll, id, SD.root_key())

    Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
  end

  # commentsがあるか確認
  def comm_def(comments, id) do
    #commentsnの存在確認
    Enum.filter(comments, fn(x) -> x["_id"] == id end)
  end

  #commentsのアップデート関数
  def comments_func(conn, coll, id, comments) do
    req_body = %Dodai.UpdateDedicatedDataEntityRequestBody{data: %{"$set" => %{"comments" => comments}  }}

    req = Dodai.UpdateDedicatedDataEntityRequest.new(SD.default_group_id(), coll, id, SD.root_key(), req_body)
          
    Sazabi.G2gClient.send(conn.context, SD.app_id(), req)
  end

end
