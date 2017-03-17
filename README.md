# nowMusicautoTweetApp

## About
今聞いている音楽をTwitter上で共有しよう！！  
毎回打ち込むのがめんどいので作ってみた

## Usage
* iOS 10 or later
* swift 3.0.2
* xcode 8.2.1

## Now Spec
* 現在ツイートは手動のみ対応
* 初回起動時の挙動がおかしい(再生中の音楽が取得できない)
* ユーザ画像でバグ(選択したアカウントと違う画像が表示される)

## Future
* 初回起動時のデータリロード(must)
* ユーザアカウントと画像を紐付けて管理(must)
* 現在再生中の音楽を自動でつぶやく(バックグラウンドで起動しているだけで.)
* 音楽が切り替わったタイミングで再生楽曲の情報更新と自動ツイート
