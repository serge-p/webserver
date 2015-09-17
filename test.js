var express = require('express');
var app = express();

var server = app.listen(4000, function () {
  var host = server.address().address;
  var port = server.address().port;

app.get('/', function (req, res) {
  var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
  res.send('Hello, this is is a very simple web server, deployed by S-VP Consulting, and by the way, your IP address is '+ip);
});

console.log('Example app listening at http://%s:%s', host, port);

});
