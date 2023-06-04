FROM python:3.9.16-slim-bullseye

ENV TZ=Asia/Shanghai

ARG PyPI_HOST=pypi.tuna.tsinghua.edu.cn
ARG PyPI_REPO=https://${PyPI_HOST}/simple
RUN echo "[global]" > /etc/pip.conf \
 && echo "timeout = 120" >> /etc/pip.conf \
 && echo "index-url = ${PyPI_REPO}" >> /etc/pip.conf \
 && echo "trusted-host = ${PyPI_HOST}" >> /etc/pip.conf


WORKDIR /code

COPY requirements-test.txt /code/requirements-test.txt
RUN pip install -r /code/requirements-test.txt

COPY test_httpbin.py /code/test_httpbin.py

# run test:
#   $ python test_httpbin.py
#   ## or pytest test_httpbin.py
#   ## or pytest -n auto test_httpbin.py
CMD [ "tail", "-f", "/dev/null" ]
