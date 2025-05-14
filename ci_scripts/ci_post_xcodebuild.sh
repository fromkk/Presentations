#!/bin/sh -x

set -e

if [[ -d "$CI_APP_STORE_SIGNED_APP_PATH" ]]; then
  TESTFLIGHT_DIR_PATH=../TestFlight
  mkdir $TESTFLIGHT_DIR_PATH

  # 現在のブランチ名を取得
  BRANCH_NAME=$(git branch --show-current)

  # 最新のコミットメッセージを取得
  LAST_COMMIT_MESSAGE=$(git log -1 --pretty=format:"%s")

  # ブランチ名と最新のコミットメッセージをファイルに書き込む
  echo "$BRANCH_NAME\n$LAST_COMMIT_MESSAGE" > $TESTFLIGHT_DIR_PATH/WhatToTest.en-US.txt
fi

