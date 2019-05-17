defmodule StackoverflowCloneA.Controller.Question.Update do
  use StackoverflowCloneA.Controller.Application

  # plugを使うことを宣言
  plug StackoverflowCloneA.Plug.FetchMe, :fetch, []


  #実行サンプル
  # curl -X PUT -H "authorization: H6EOMlPraoSmB5fSNjjV" -H "Content-type: application/json" -d '{"title":"hoge_t" ,"body":"hoge_b"}' http://stackoverflow-clone-a.localhost:8080/v1/question/5cde04176e1dc843f6aa53ae | jq

  def update(conn) do
    # Implement me

    IO.inspect conn


    Conn.json(conn, 200, %{"hoge" => "test"})
  end
end
