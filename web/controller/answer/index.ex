defmodule StackoverflowCloneA.Controller.Answer.Index do
  use StackoverflowCloneA.Controller.Application

  def index(conn) do
    # Implement me

    Conn.json(conn, 400, %{"result" => "not found"})
  end
end
