mongolog.js
===========

###monolog for javascript and node

author mparaiso <mparaiso@online.fr>

inspired by https://github.com/Seldaek/monolog

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