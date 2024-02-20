
パッケージを生成するリポジトリを配置します
パッケージ生成は `setup.py` がリポジトリのルート配下に配置されていることを想定しています。

```
mkdir -p packages # パッケージ化するリポジトリを配置する
mkdir -p dist  # パッケージが出力されるディレクトリ

cd packages
git clone https://github.com/psf/requests
cd ..
```

```
docker compose up -d --build pypi-server
```

パッケージを生成します。
dist 上に配置されたパッケージが pypi server で公開されます。
dist は常にクリーンアップされます（バージョン管理せず、常に最新版のみ配置されます）

```
docker exec -it pypi-server scripts/install_packages.sh packages dist
```

pypi サーバーで公開されているパッケージを確認します。

```
curl http://localhost:8080/simple/
```

パッケージは次のようにインストールできます。

```
pip install --force-reinstall requests --trusted-host --index-url http://localhost:8080/simple/
```

```
docker compose down pypi-server
```
