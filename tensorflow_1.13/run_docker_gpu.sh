#!/bin/bash
set -e
set -x


# コンテナの元になるイメージ
IMAGE_NAME=tftest
IMAGE_TAG=1.13_gpu

# 起動するコンテナ名
CONTAINER_NAME=tftest_1_13_gpu

# コンテナにログインするユーザ名
USER_NAME=tftest



# コンテナがまだ作られてないなら(再開に失敗したら)、コンテナを作る
nvidia-docker start $CONTAINER_NAME > /dev/null 2> /dev/null || {

    echo "Creating new container..."

    # detach: コンテナをバックグラウンドで起動
    # volume: コンテナにディレクトリマウント。TimeZoneをそろえる
    nvidia-docker run                                               \
        --env http_proxy=${http_proxy}                              \
        --env https_proxy=${https_proxy}                            \
        --detach                                                    \
        --net=host                                                  \
        --volume $PWD/share_volume:/home/$USER_NAME/share_volume    \
        --volume /etc/localtime:/etc/localtime:ro                   \
        --name ${CONTAINER_NAME}                                    \
        --tty                                                       \
        ${IMAGE_NAME}:${IMAGE_TAG}

    # コンテナ初回起動時に１回だけ行う設定
    nvidia-docker exec --user $USER_NAME $CONTAINER_NAME /home/$USER_NAME/share_volume/env/setup_env.sh
}


# コンテナ上で bash を起動
if [ "$#" -eq  "0" ]; then
    nvidia-docker exec --interactive --tty --user $USER_NAME $CONTAINER_NAME bash
else
    nvidia-docker exec --interactive --tty --user $USER_NAME $CONTAINER_NAME bash -c "$@"
fi


