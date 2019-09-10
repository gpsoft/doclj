# VimでClojureScriptを始めるためのサンプルプロジェクト

## セットアップ

使うツールは:

- Clojureの[CLIツール(tools.deps)](https://clojure.org/guides/getting_started)
- [figwheel](https://github.com/bhauman/figwheel-main)
- [rebel-readline](https://github.com/bhauman/rebel-readline)
- nREPLサーバ
- [piggieback](https://github.com/nrepl/piggieback)
- Vim
- [vim-fireplace](https://github.com/tpope/vim-fireplace)

などなど。

いろいろインストールするのは面倒、という場合は、Dockerを使う。

    $ git clone https://github.com/gpsoft/doclj.git
    $ cd doclj
    $ make image
    $ make dev

これで、Dockerコンテナの中に入った。このコンテナには、上記のツール群がインストール済み。ちなみに、別のターミナルからこのコンテナに入るには、以下でOK。

    $ cd doclj
    $ make attach

## 開発

コンテナの中で、まずはサーバ群を起動:

    $ cd cljs-sample
    $ clojure -Adev
    ...
    Opening URL http://localhost:9500
    Failed to open browser: 
    No X11 DISPLAY variable was set, but this program performed an operation which requires it.

ブラウザで`http://localhost:9500`を開こうとするが、コンテナの中なので失敗している。しかし9500ポートはホスト側にも見えるように設定してあるので、ホスト側でブラウザを開けば良い。するとfigwheelサーバとつながり、自動ビルド&リロードのための監視が始まる。

この時点で、CLJSソースやCSSファイルを修正すると、即、ブラウザに反映されるようになっている。これだけでも効率が上がるが、やはりClojure/ClojureScriptで開発するなら、エディタとREPLを連携させたい。そこで、別のターミナルから、Vimで`core.cljs`を開いてみる。

    $ cd cljs-sample
    $ vim src/sample/core.cljs

Vim上で、以下のコマンドを実行すれば、nREPLサーバと連携してCLJS REPLセッションが始まる。

    :Piggieback

このCLJS REPLセッション上で実行するコードは、実際はブラウザ上で動いていると考えて良い。vim-fireplaceのcppやcprといったキーマッピングを使えば、エディタの中から自由にClojureScriptコードを実行することができる。

nREPLサーバのポート(3575)はホスト側から見えるので、ホスト側のVimからも同じことができる。ただし、その場合、`.vimrc`に下記の設定を追加しておく必要がある。

    let g:fireplace_cljs_repl =
          \ '(cider.piggieback/cljs-repl (figwheel.main.api/repl-env "dev"))'

Figwheelの開発用のビルドオプションは、`dev.cljs.edn`に記述。

## リリース

リリース用のビルドオプションは、`prod.cljs.edn`に記述。

ビルド:

    $ clojure -Aprod

あとは、`resources/public/`の下をWebサーバへデプロイする(あるいは、ブラウザで直接`index.html`を開く)だけ。

## 新規プロジェクト

このサンプルプロジェクトをコピって新規プロジェクトを始める場合は、名前空間`sample.core`を好きなように変更すれば良い。変更箇所は以下の通り。

- `dev.cljs.edn`の`:main`
- `prod.cljs.edn`の`:main`
- `src/sample/`のディレクトリ名
- `src/sample/core.cljs`の`ns`フォーム
