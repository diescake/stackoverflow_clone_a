defmodule StackoverflowCloneA.Controller.Answer.IndexTest do
  use StackoverflowCloneA.CommonCase
  alias StackoverflowCloneA.TestData.AnswerData
  alias Sazabi.G2gClient

  @api_prefix "/v1/answer"
  
  # テストの説明
  test "index/1 " <>
    "user_id only" do
    :meck.expect(G2gClient, :send, fn(_, _, req) ->
      assert req.query.query == %{"data.user_id": "98765"}
      %Dodai.RetrieveDedicatedDataEntityListSuccess{body: [AnswerData.dodai()]}
    end)

    res = Req.get(@api_prefix <> "?user_id=98765")
    assert res.status               == 200
  end

  test "index/1" <>
    "user_id question_id" do
    :meck.expect(G2gClient, :send, fn(_, _, req) ->
      assert req.query.query == %{"data.user_id": "98765", "data.question_id": "12345678"}
      %Dodai.RetrieveDedicatedDataEntityListSuccess{body: [AnswerData.dodai()]}
    end)
    res = Req.get(@api_prefix <> "?user_id=98765&question_id=12345678")
    assert res.status               == 200
  end
end
