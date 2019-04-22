# Webfrontend実習1日目

## 内容

ハンズオンに引き続き、実習を行う。

* `質問詳細ページ(2. コメントの表示)`を実装する。
  * 質問にコメントがついている場合それを表示するように修正する。
  * 下記のファイルを修正する。
    * [Question.vue](../../web/static/components/Question.vue)
    * [Question.spec.js](../../js_test/components/Question.spec.js)
    * [Comment.vue](../../web/static/components/Comment.vue)
    * [Comment.spec.js](../../js_test/components/Comment.spec.js)

## ヒント

* `質問詳細ページ(2. コメントの表示)`に関して、Vueでは`v-for`を利用してテンプレート内で特定のリストに対する繰り返しを実現できる。参照: [List Rendering](https://vuejs.org/v2/guide/list.html)。
```
<div
  v-for="comment in question.comments"
  :key="comment.id">
  <comment
    :comment="comment"
  />
  <hr>
</div>
```
