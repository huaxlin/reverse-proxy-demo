# reverse-proxy demo

![reverse-proxy-demo.jpeg](https://s2.loli.net/2023/06/04/JZCDzBI7ibo5qAN.jpg)

## Usage

```shell
$ docker-compose build reverse_proxy
$ docker-compose build test_httpbin
$ docker-compose up -d
$ docker-compose exec test_httpbin bash
# pytest -n auto test_httpbin.py
```
