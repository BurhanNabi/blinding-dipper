# Ruby Server

A cool ruby server that handle simple requests involving timeouts.

# Compatible requests
The following request are hanlded:
1. Set a new timeout

	localhost:2016/api/response?connId=myConnId&timeout=myTimeout

e.g

```bash
curl -v localhost:2016/api/response?connId=1\&timeout=70
```

2. Get server status

	localhost:2016/api/serverStatus

e.g.

```bash
curl -v localhost:2016/api/serverStatus
```


3. Kill a timeout

	PUT localhost:2016/api/kill with data {"connID" : idToKill}

e.g.

```bash
curl -v -X PUT localhost:2016/api/kill -d '{"connId" : 1}'
```