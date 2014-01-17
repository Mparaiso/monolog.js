AbstractProcessingHandler=require('./AbstractProcessingHandler')

class ConsoleLogHandler extends AbstractProcessingHandler

	write:(record,cb)->
		console.log(record.formatted)
		cb(undefined,record,this) if cb instanceof Function

module.exports = ConsoleLogHandler