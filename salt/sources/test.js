var express = require('express');
var app = express();

var server = app.listen(4000, function () {
  var host = server.address().address;
  var port = server.address().port;

app.get('/', function (req, res) {
  var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
  res.send('<h1> Hello World! <br> this is is a simple web server<br> deployed by Sergey Paramonov<br>And by the way, your IP address is '+ip+'</h1>');
});

console.log('Example app listening at http://%s:%s', host, port);


});
