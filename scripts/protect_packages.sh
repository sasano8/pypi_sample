#!/bin/sh -e

PACKAGES_DIR=$(realpath $1)
DIST_DIR=$(realpath $2)

echo "[SETUP   ]PACKAGES_DIR=$PACKAGES_DIR"
echo "[SETUP   ]DIST_DIR=$DIST_DIR"

echo "[PROCESS]$DIST_DIR => clean up directory"
rm -rf $DIST_DIR/*


# PACKAGES_DIR 内のすべてのサブディレクトリをループ処理
for dir in "$PACKAGES_DIR"/*; do
  if [ -d "$dir" ]; then
    if [ -f "$dir/setup.py" ]; then
      # setup.py の実行
      # 配布方式は sdist, bdist_wheel 形式がある
      # bdist_wheel はコンパイル済みモジュールやバイナリを含めることができる
      # ソースだけ提供する場合は sdist を選択でよい
      echo "[PROCESS]$dir"
      (cd "$dir" && pyarmor obfuscate --src . --output $DIST_DIR --recursive --exclude tests/ "app.py setup.py")
    else
      echo "[SKIP   ]$dir => setup.py not found."
    fi
  fi
done

