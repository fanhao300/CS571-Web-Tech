var http = require('http');
http.createServer(function (req, resp) {
var h = req.headers;
h.host = "stackoverflow.com";


var req2 = http.request({
host: h.host, port: 80, path: req.url, method: req.method, headers: h
}, function (resp2) {
resp.writeHead(resp2.statusCode, resp2.headers);
resp2.on('data', function (d) { resp.write(d); });
resp2.on('end', function () { resp.end(); });
});
req.on('data', function (d) { req2.write(d); });
req.on('end', function () { req2.end(); });
console.log('Server running at http://127.0.0.1:1337/ echoing '+h.host);
}).listen(1337, "127.0.0.1");


