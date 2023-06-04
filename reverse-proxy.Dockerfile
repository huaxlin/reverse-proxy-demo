FROM python:3.9.16-slim-bullseye

ENV TZ=Asia/Shanghai

ARG PyPI_HOST=pypi.tuna.tsinghua.edu.cn
ARG PyPI_REPO=https://${PyPI_HOST}/simple
RUN echo "[global]" > /etc/pip.conf \
 && echo "timeout = 120" >> /etc/pip.conf \
 && echo "index-url = ${PyPI_REPO}" >> /etc/pip.conf \
 && echo "trusted-host = ${PyPI_HOST}" >> /etc/pip.conf


WORKDIR /code

COPY requirements.txt /code/requirements.txt
RUN pip install -r /code/requirements.txt

COPY server-start.sh /code/server-start.sh
COPY reverse_proxy.py /code/reverse_proxy.py


ENV PYTHONPATH "/code:$PYTHONPATH"
CMD [ "/bin/bash", "server-start.sh" ]
