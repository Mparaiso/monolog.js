mongolog.js
===========

https://github.com/Mparaiso/monolog.js

[![NPM](https://nodei.co/npm/monolog.png)](https://nodei.co/npm/monolog/)


[![Build Status](https://travis-ci.org/Mparaiso/monolog.js.png?branch=master)](https://travis-ci.org/Mparaiso/monolog.js)

[![Coverage Status](https://coveralls.io/repos/Mparaiso/monolog.js/badge.png)](https://coveralls.io/r/Mparaiso/monolog.js)


###Log everything everywhere, monolog for javascript and node

author mparaiso <mparaiso@online.fr>

heavily inspired by [monolog](https://github.com/Seldaek/monolog) PHP library

###Installation

	npm install -g monolog

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
	logger.pushHandler(new monolog.handler.ConsoleLogHandler);
	// a WebProcessor extracts data from each request and add it to the log records
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

#### Creating a simple logger middleware for express

in a file called logger.js

```javascript
	 "use strict";
	 /**
	  * monolog middleware for connect and express
	  * USAGE
	  * =====
	  * var app=express()
	  * app.use(logger.middleware(app,"debugging"));
	  * 
	  */
	 var monolog = require('monolog');
	 /**
	  * @type {monolog.Logger}
	  */
	 var logger = new monolog.Logger("express logger");

	 logger.addHandler(new monolog.handler.StreamHandler(__dirname + "/../temp/log.txt"));
	 /**
	  * [middleware description]
	  * @param  {Express} app     express app
	  * @param  {String} message log message
	  * @return {Function}         middleware
	  */
	 logger.middleware = function(app, message) {
	 	message = message || "debug";
	 	logger.addProcessor(new monolog.processor.ExpressProcessor(app));
	 	app.set('logger', logger);
	 	var F =  function(req, res, next) {
	 		logger.debug(message);
	 		next();
	 	};
	 	F.logger = logger;
	 	return F;
	 };

	 module.exports = logger;
```