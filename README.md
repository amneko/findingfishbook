# Finding Fish Book

## サービス概要
Finding Fish Bookは、任天堂のゲームソフト『あつまれ どうぶつの森』(以降、あつ森と記載。)
内に出現する魚の写真と現実の水族館を紐付けて投稿するサービスです。

## 想定されるユーザー層
* あつ森ユーザー
* 魚類/水族館が好き、興味があるユーザー

## サービスコンセプト
ゲーム/アニメ/漫画に影響を受けて、関連する現実の人物や出来事に興味を持つことがあり、
ユーザーにもそのような体験をしてもらいたいと思ったことが、本サービスを作成するきっかけになりました。
(フィクションで見たものをリアルで見つけた時の"これ知ってる！"となる瞬間が楽しいと感じます)

ユーザーが現実の施設に行きたいと思ってもらえるような、
フィクションとリアルの仲介役になるアプリを作りたいと考えています。
裏テーマは"皆で作る図鑑"(ユーザ皆で情報を登録していきひとつの図鑑を完成させていくイメージ)です。

あつまれどうぶつの森に出現する魚のみ対象としている点が、
他の図鑑系アプリとの差別化ポイントになると考えています。
あつ森×水族館とすることで、あつ森ユーザおよび水族館好きユーザの
両方をターゲットにすることができます。

## 実装を予定している機能
### MVP
* あつ森で今釣れる魚表示機能(サービストップ画面に配置。ログイン不要で利用可能な機能とする。)
* ユーザ管理
  * ユーザ登録
  * ユーザ削除
  * ログイン/ログアウト
  * お気に入り魚機能
* 魚管理
  * 魚一覧(未ログインでも確認可能)
  * 魚詳細
    * 投稿時に設定した値を表示する。
* 投稿
  * 投稿一覧(未ログインでも確認可能)
  * 新規投稿
    * 魚の名前(必須。実際に見た魚の名前を一覧から選択。)
    * コメント
    * この魚と出会った水族館(必須。水族館名を一覧から選択。)
    * 出会った日付(展示期間があるかもしれないため。)
    * 魚の写真
      * CarrierWave、MiniMagickを利用。画像のリサイズと、画像データの容量制限を行う。
      * Google Cloud Vision APIを導入し、投稿時に魚の画像か否かを診断。魚以外の画像投稿を防ぐ。
  * 投稿削除
* 水族館管理
	* 水族館一覧(未ログインでも確認可能)
  * 水族館登録(管理者のみ登録可能とする)
	  * 水族館名(必須)
	  * 場所(必須。入力するなら詳細な住所まで登録する)
      * Webサイト
  * 水族館詳細
    * 水族館登録と同じ項目
### その後の機能(本リリースまでに実装予定)
* 登録済魚へのコメント投稿
* 水族館マップ(登録済水族館をマップ上に表示する)
    * ユーザ登録可能にすると登録データにばらつきが出る可能性があるため、事前に用意する。
    基本以下に掲載されている水族館を対象にする予定。掲載されていない場所でも良い水族館があれば登録する。
    * 日本動物園水族館協会
        https://www.jaza.jp/about-jaza/structure/list-aquarium
    * NAVITIME 全国の水族館
        https://www.navitime.co.jp/category/0101005/
* ユーザ管理
    * 登録情報編集
    * パスワードリセット
* 管理画面(魚や水族館のデータ追加などを行う)

## 機能の実装方針予定
* バックエンド
    * Ruby：最新安定バージョンを使用。
    * Rails：最新安定バージョンを使用。
* その他使用予定gem
    * CarrierWave、MiniMagick：最新安定バージョンを使用。魚の画像投稿用。
    * Google Maps PlatformもしくはGeocoder：最新安定バージョンを使用。水族館マップ用。
* CSSフレームワーク
    * Bulma：最新安定バージョンを使用。
* API
    * Google Cloud Vision API：魚の画像診断用。
        https://cloud.google.com/vision?hl=ja
* フロントエンド
    * Vue.jsを検討していたが必要な場面がなかったため今回は導入を見送り。
* デプロイ先：Herokuを使用。

## 画面遷移図
https://www.figma.com/file/kGh9r9aQPY11DUCgklfxt3/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=FtXanWWSryexNmY2-1

## ER図
![ER図](er_diagram/ER_Diagram_20240218_01.png)