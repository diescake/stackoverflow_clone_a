# Q&A

## 画像を利用したい場合どうすればいいですか？

- [imgsフォルダ](../../web/static/imgs)の中に画像を置くとcssからurl()を利用して読み込めます。下記の[Header.vue](../../web/static/components/Header.vue)で利用しているので参考にしてください。
- デプロイ時にvueファイルはwebpackでのビルドでまとめられてURL上の位置が変わるので、[url-loader](https://github.com/webpack-contrib/url-loader)を利用して画像をbase64 Urlとしてビルド時に埋め込んでいます。
  - 本来は大きな画像をbase64 Urlとして埋め込むのは良くないですが、演習の構造をシンプルにするためこの方法のみを提供しています。
