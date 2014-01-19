"use strict";
/*
Server Request Logging with monolog
*/

var http, logger, monolog, port, server;

http = require('http');
monolog = require('../index');
port = 3000;
server = http.createServer();
logger = new monolog.Logger();
logger.pushHandler(new monolog.handler.ConsoleLogHandler());
logger.pushProcessor(new monolog.processor.WebProcessor(server));

server.on('request', function(req, res) {
  logger.info('logging request');
  return res.end('ok!');
});

server.listen(3000);

console.log("listening on port " + port);
