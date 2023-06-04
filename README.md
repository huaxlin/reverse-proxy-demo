# reverse-proxy demo

## Usage

```shell
$ docker-compose build reverse_proxy
$ docker-compose build test_httpbin
$ docker-compose up -d
$ docker-compose exec test_httpbin bash
# pytest -n auto test_httpbin.py
```
