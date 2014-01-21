"use strict"

monolog = 
	Logger:require('./Logger')
	handler:
		AbstractHandler:require('./handler/AbstractHandler')
		AbstractProcessingHandler:require('./handler/AbstractProcessingHandler')
		ConsoleLogHandler:require('./handler/ConsoleLogHandler')
		NullHandler:require('./handler/NullHandler')
		TestHandler:require('./handler/TestHandler')
		StreamHandler:require('./handler/StreamHandler')
		CouchDBHandler:require('./handler/CouchDBHandler')
	formatter:
		LineFormatter:require('./formatter/LineFormatter')
		NormalizerFormatter:require('./formatter/NormalizerFormatter')
	processor:
		WebProcessor:require('./processor/WebProcessor')
		ExpressProcessor:require('./processor/ExpressProcessor')

monolog.create = -> new monolog.Logger(arguments...)

module.exports = monolog

