"use strict"


###
	Usage

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
###

monolog = 
	Logger:require('./Logger')
	handler:
		AbstractHandler:require('./handler/AbstractHandler')
		AbstractProcessingHandler:require('./handler/AbstractProcessingHandler')
		ConsoleLogHandler:require('./handler/ConsoleLogHandler')
		NullHandler:require('./handler/NullHandler')
		TestHandler:require('./handler/TestHandler')
		StreamHandler:require('./handler/StreamHandler')
	formatter:
		LineFormatter:require('./formatter/LineFormatter')
		NormalizerFormatter:require('./formatter/NormalizerFormatter')

module.exports = monolog

