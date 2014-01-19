mongolog.js
===========

[![NPM](https://nodei.co/npm/monolog.png)](https://nodei.co/npm/monolog/)


[![Build Status](https://travis-ci.org/Mparaiso/monolog.js.png?branch=master)](https://travis-ci.org/Mparaiso/monolog.js)


Logging everything everywhere, monolog for javascript and node
--------------------------------------------------------------

author mparaiso <mparaiso@online.fr>

heavily inspired by [monolog](https://github.com/Seldaek/monolog)

###Usage

####Basic usage

```javascript
	var monolog = require('monolog')
		, Logger = monolog.Logger
		, StreamHandler = monolog.handler.StreamHandler;

	//create a Log channel
	var log = new Logger('name')
	//create a Log handler
	log.pushHandler(new StreamHandler('/path/to/your.log',Logger.DEBUG))
	//listen to log events
	log.on("log",function(error,record,handler){console.log(arguments)});
	// add records to the log
	log.warn('Foo')
	log.err('Bar')
	log.debug('Baz')
```

####Server request logging

```javascript
	var http, logger, monolog, port, server, webProcessor;

	http = require('http');
	monolog = require('./index');
	port = 3000;
	server = http.createServer();
	logger = new monolog.Logger("server logger");
	webProcessor = logger.pushHandler(new monolog.handler.ConsoleLogHandler);

	logger.pushProcessor(new monolog.processor.WebProcessor(server));

	server.on('request', function(req, res) {
	  logger.info('logging request');
	  return res.end('ok!');
	});

	server.listen(3000);

	console.log("listening on port " + port);
```

#### CouchDB Logging

```javascript
	var monolog,logger;

	monolog=require('./monolog');
	logger = new monolog.Logger("couchdb logger");
	logger.pushHandler(new monolog.handler.CouchDBHandler({
		host:"localhost",
		dbname:"logger"
	}));
	logger.on('log',function(err,res,record,handler){
		console.log(arguments);
	});
	logger.info('Logging to couchdb');
```