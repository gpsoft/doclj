# VimでClojureScriptを始めるためのサンプルプロジェクト

# セットアップ

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

コンテナの中で、まずはサーバ群を起動:

    $ cd cljs-sample
    $ clojure -Adev
    ...
    Opening URL http://localhost:9500
    Failed to open browser: 
    No X11 DISPLAY variable was set, but this program performed an operation which requires it.

ブラウザで`http://localhost:9500`を開こうとするが、コンテナの中なので失敗している。しかし9500ポートはホスト側にも見えるように設定してあるので、ホスト側でブラウザを開けば良い。するとfigwheelサーバとつながり、自動ビルド&リロードのための監視が始まる。

次に、別のターミナルから、Vimで`core.cljs`を開いて、nREPLサーバと接続しCLJS REPLセッションを開始:

    $ cd cljs-sample
    $ vim src/sample/core.cljs
    :Piggieback

これで、vim-fireplaceのcppやcprが使えるようになった。nREPLサーバのポート(3575)もホスト側から見えるので、ホスト側のVimからも同じことができる。ただし、その場合、`.vimrc`に下記の設定を追加しておく必要がある。

    let g:fireplace_cljs_repl =
          \ '(cider.piggieback/cljs-repl (figwheel.main.api/repl-env "dev"))'

Figwheelの開発用のビルドオプションは、`dev.cljs.edn`に記述。

# リリース

リリース用のビルドオプションは、`prod.cljs.edn`に記述。

ビルド:

    $ clojure -Aprod

あとは、`resources/public/`の下をWebサーバへデプロイする(あるいは、ブラウザで直接`index.html`を開く)だけ。
