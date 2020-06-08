#!/usr/bin/python3


class FilterModule(object):
    def filters(self):
        return {"haproxy_backend_servers": self.haproxy_backend_servers}

    def haproxy_backend_servers(self, keys):
        backends = []
        for i, key in enumerate(keys):
            backends.append({"name": "backend%d" % i, "address": "%s:80" % key})
        return backends
