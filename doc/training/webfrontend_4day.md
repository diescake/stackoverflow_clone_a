# Webfrontend実習4日目

## 内容

* `質問詳細ページ(5. 回答の表示・追加・編集。回答へのコメントの追加・編集)`を実装する。
  * 作成済みの`質問詳細ページ`に対して、ログイン済みの自分や他のユーザーが回答の追加や編集、回答へのコメントの追加・編集をできるようにする。
  * 下記のファイルを修正する。
    * [QuestionDetailPage.vue](../../web/static/pages/QuestionDetailPage.vue)
    * [QuestionDetailPage.spec.js](../../js_test/pages/QuestionDetailPage.spec.js)
    * [Answer.vue](../../web/static/components/Answer.vue)
    * [Answer.spec.js](../../js_test/components/Answer.spec.js)

* 発表に向けた見栄えの改善＆オリジナリティの追加やオプショナル課題を行う。
  * 発表に向けた見栄えの改善＆オリジナリティの追加。
    * 例) StackOverflowにもっと近づける or 全く別の見た目にする。
    * 例) 他のユーザーから更新がされた場合に自動的に再読み込みをする。
    * 例) 目を引くエフェクトを付ける。
  * Voteの実装
  * pagenationの実装

## ヒント

* Vue.jsでは[transitionコンポーネント](https://vuejs.org/v2/guide/transitions.html)を利用して、簡単にエフェクトを付けれる。
