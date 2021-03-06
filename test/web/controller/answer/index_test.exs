defmodule StackoverflowCloneA.Controller.Answer.IndexTest do
  use StackoverflowCloneA.CommonCase
  alias StackoverflowCloneA.TestData.AnswerData
  alias Sazabi.G2gClient

  # router.ex ルートの名前
  @api_prefix "/v1/answer"
  
  test "index/1 " <>
  # テストの説明
    "user_id only" do
    # :meck.expect(モジュール名, 使いたい関数名, fn(_, _, req)ここはメックの中で使用する部分だけを書けば良い
    :meck.expect(G2gClient, :send, fn(_, _, req) ->
      # assert 主張　確認をしっかりしたいみたいな意味
      assert req.query.query == %{"data.user_id": "98765"}
      # bodyの中にanswer_data.exsの中の関数を入れている
      %Dodai.RetrieveDedicatedDataEntityListSuccess{body: [AnswerData.dodai()]}
    end)
    # ルートの後ろにクエリストリングスを付けるということ
    res = Req.get(@api_prefix <> "?user_id=98765")
    # ここまでうまくいけば200ください
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
