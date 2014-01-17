"use strict"

monolog = 
	Logger:require('./Logger')
	handler:
		AbstractHandler:require('./handler/AbstractHandler')
		AbstractProcessingHandler:require('./handler/AbstractProcessingHandler')
		ConsoleLogHandler:require('./handler/ConsoleLogHandler')
		NullHandler:require('./handler/NullHandler')
	formatter:
		LineFormatter:require('./formatter/LineFormatter')
		NormalizerFormatter:require('./formatter/NormalizerFormatter')

module.exports = monolog
