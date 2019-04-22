# Webfrontend実習3日目

## 内容

* `質問詳細ページ(4. 質問へのコメントの追加・編集)`を実装する。
  * 作成済みの`質問詳細ページ`に対して、ログイン済みの自分や他のユーザーが質問へのコメントを追加し、追加した人がコメントを編集できるようにする。
  * 下記のファイルを修正する。
    * [Question.vue](../../web/static/components/Question.vue)
    * [Question.spec.js](../../js_test/components/Question.spec.js)
    * [Comment.vue](../../web/static/components/Comment.vue)
    * [Comment.spec.js](../../js_test/components/Comment.spec.js)
  * お手本にはコメントの追加時にアニメーションがあるが対応は不要。余裕があればオプショナル課題として好きなエフェクトを追加していい。

## ヒント

* コメントの実装は質問へのコメントと同じコンポーネント([Comment.vue](../../web/static/components/Comment.vue))を利用できる。ただ、別にファイルを作成しても構わない。
  * 共通にする場合、更新処理は異なるため、Commnetからeventをemitして、親(Question, Answer)でハンドルして更新する必要がある。
