

```
docker compose up -d --build pypi-server
```

```
docker exec -it pypi-server /bin/bash -c "cd packages && git clone https://github.com/psf/requests"
```

```
docker exec -it pypi-server scripts/install_packages.sh packages dist
```

```
curl http://localhost:8080/simple/
```

```
pip install --force-reinstall requests --extra-index-url http://localhost:8080/simple/
```

```
docker compose down pypi-server
```
