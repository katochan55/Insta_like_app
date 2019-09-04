# 自分が苦労した点
・開発を進める中で、C9を閉じると毎回herokuコマンドが使えなくなるという事象が発生。
　vimで.bash_procfileを直接編集してherokuへPATHを通すことで解決しましたが、vimの使い方や.bash_procfileの扱い方に慣れておらず苦労した。

・「変数が見つからない」というエラーが度々発生。
　アクションごとに、コントローラでどのインスタンス変数をどのように定義する必要があるか考えるのに苦労した。

・エラー「ActiveRecord::InvalidForeignKey: PG::ForeignKeyViolation: ERROR:  update or delete on table "users" violates foreign key constraint...」(詳しくは割愛)が発生し、それが解決できず苦労した。
　Slackで質問させていただいたところ、DB周りの権限系エラーとのこと。(開発環境ではテストが通っていたので一旦良しとした)


# 学んだ点
・master以外の環境をherokuにpushする方法を学んだ（git push heroku 開発ブランチ名:master）。
・必要なテストを自分で考えて書くことで、minitestの書き方についてかなり勉強になった。
・Bootstrapのルールを学び、使うことができた(Railsチュートリアルでは何も考えずに使っていた)。
・お気に入り、コメント、通知機能などを実装することで、リソース間の関係性を意識しながら実装していく方法を学んだ。


# 自慢したい・相談したい点
## 自慢したい点
・なるべくパーシャルを使用し、コードが冗長にならないように書いた。
・お気に入り登録/解除の切り替えにAjaxを使用し、無駄なリダイレクトを無くした。
・リソースごとに必要なアクションやビュー、テストを絞り込み、不要なものはなるべく作成しないようにした。
・実装内容についてではないが、RailsガイドやRuby APIなどを参考にして自力でエラー解決する力がアップしたと思う。

## 相談したい点
・herokuでテストを流したときに、「rails-controller-testing」というgemが見つからないというエラーが発生し詰まったことがあった。
　最終的にはGemfileの group :production do ... end 内に上記gemを入れてpushすることで解決したが、個人的に無理矢理感があったと考えている。
　実際の開発現場の方から見て、この対応はどう思われるでしょうか？

　※ちなみに、「heroku run bundle update」を実行すると下記のようなエラーが発生していた。
　「You are trying to install in deployment mode after changing your Gemfile. Run `bundle install` elsewhere and add the updated Gemfile.lock to version control.」

・Railsチュートリアル第3章 3.1.6 minitest reporters を導入しようとしたが、masterではない環境だとうまくいかなかった。
　master以外だと、使えないものなのでしょうか？

・通知のあり・なしを判別するのにグローバル変数($NOTIFICATION_FLAG)を使用したが、もっと良い方法はなかったか？
　グローバル変数の値を1と0とで切り替えて使用したが、グローバル変数を使う場合は基本的に値を変えずに使用するものと理解している。
　そのため今回、最初にインスタンス変数、次にクラス変数を試したが、いざ通知一覧ページでその値を使おうとすると変数が見つからないとエラーが出てうまくいかなかった。
