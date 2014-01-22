"use strict"

###
monolog
@type {monolog}
@namespace monolog
###
Monolog = 
	Logger:require('./Logger')
	handler:
		AbstractHandler:require('./handler/AbstractHandler')
		AbstractProcessingHandler:require('./handler/AbstractProcessingHandler')
		ConsoleLogHandler:require('./handler/ConsoleLogHandler')
		NullHandler:require('./handler/NullHandler')
		TestHandler:require('./handler/TestHandler')
		StreamHandler:require('./handler/StreamHandler')
		CouchDBHandler:require('./handler/CouchDBHandler')
		MongoDBHandler:require('./handler/MongoDBHandler')
	formatter:
		LineFormatter:require('./formatter/LineFormatter')
		NormalizerFormatter:require('./formatter/NormalizerFormatter')
	processor:
		WebProcessor:require('./processor/WebProcessor')
		ExpressProcessor:require('./processor/ExpressProcessor')

###
	create Logger
	@param {String} name
	@param {Array} handlers
	@param {Array} processors
	@return {monolog.Logger} 
###
Monolog.create = -> new Monolog.Logger(arguments...)

module.exports = Monolog

