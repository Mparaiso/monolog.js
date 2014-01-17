AbstractProcessingHandler=require('./AbstractProcessingHandler')

class ConsoleLogHandler extends AbstractProcessingHandler

	write:(record)->
		if console[record.level] instanceof Function
			console[record.level](record.formatted)
		else
			console.log(record.formatted)
		return

module.exports = ConsoleLogHandler