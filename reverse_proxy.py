from __future__ import annotations
import os
import re

from proxy.http import Url
from proxy.http.parser import HttpParser
from proxy.http.server import ReverseProxyBasePlugin
from proxy.common.types import RePattern
from proxy.http.exception.base import HttpProtocolException

PROXY_PASS_BASE_URL = os.environ["PROXY_PASS_BASE_URL"]


class ReverseProxyPlugin(ReverseProxyBasePlugin):
    def routes(self) -> list[str | tuple[str, list[bytes]]]:
        return [
            r'/(.*)$',
        ]

    def handle_route(self, request: HttpParser, pattern: RePattern) -> Url:
        assert request.path

        result = re.search(pattern, request.path.decode())
        if not result or len(result.groups()) != 1:
            raise HttpProtocolException('Invalid request')

        choice: Url = Url.from_bytes(PROXY_PASS_BASE_URL.encode("utf-8"))
        assert choice.remainder == b'/'

        choice.remainder += result.groups()[0].encode()
        return choice
