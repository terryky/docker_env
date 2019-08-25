tensorflow を使うための docker 環境構築マニュアル


■docker イメージの作成（最初に１回だけ）

> ./build_image.sh


※下記 dockerイメージが生成される
　イメージ名：tftest
　タグ名    ：1.13



■docker コンテナ実行（docker環境立ち上げのたびに）

> ./run_docker.sh


※初回コンテナ生成時に、.bashrc に alias 追加などの処理を行います。






===============================================================================
■前準備
===============================================================================

■docker インストール
> curl -fsSL http://get.docker.com -o get-docker.sh   # -o で保存先ファイル名を指定
> CHANNEL=stable sh get-docker.sh                     # 念のため stable 版を指定

　　※途中、sudo するためのパスワードを求められるので入力する



■ホストPCの docker デーモンの DNS 設定をしておく
  これをしないと、DNS = 8.8.8.8 に設定されるが、proxy環境下でアクセスできないことがある

> vi /etc/docker/daemon.json
{
    "dns": [
        "xxx.xxx.xxx.xxx", "xxx.xxx.xxx.xxx"
    ],
    "dns-opts": [
        "timeout:1"
    ]
}


■dockerデーモン再起動
 $ sudo systemctl daemon-reload
 $ sudo systemctl restart docker


■Docker を一般ユーザで実行できるように、docker グループに追加
> sudo usermod -aG docker $USER
> sudo systemctl restart docker

