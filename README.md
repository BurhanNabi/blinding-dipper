# Ruby Server

A cool ruby server that handle simple requests involving timeouts.

### Compatible requests
The following request are handled:

##### Set a new timeout

localhost:2016/api/response?connId=myConnId&timeout=myTimeout
e.g

```bash
curl -v localhost:2016/api/response?connId=1\&timeout=70
```

##### Get server status

localhost:2016/api/serverStatus
e.g.

```bash
curl -v localhost:2016/api/serverStatus
```


##### Kill a timeout

PUT localhost:2016/api/kill with data {"connID" : idToKill}
e.g.

```bash
curl -v -X PUT localhost:2016/api/kill -d '{"connId" : 1}'
```

###### Note to stop seeing the verbose output in the curl commands , remove the ```-v``` flag from the curls


## How To Run

Change into to the directory containig the server

###### Run the server
```bash
ruby server.rb
```
###### Send Requests from another terminal
```bash
curl -v localhost:2016/api/response?connId=1\&timeout=70
```

or any of the other requests
