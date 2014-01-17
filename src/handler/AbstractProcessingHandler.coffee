AbstractHandler = require('./AbstractHandler')

class AbstractProcessingHandler extends AbstractHandler
	
	# @return {Boolean}
	handle:(record,cb)->
		if @isHandling(record)
			record = @processRecord(record)
			
			record.formatted = if @getFormatter() 
				@getFormatter().format(record)  
			else 
				record.message

			@write(record,cb)
			@bubble==false
			false
		else
			false

	write:(record)->
		throw new Error('not implemented yet');return

	processRecord:(record)->
		if @processors
			for processor in @processors     
				record = processor(record)
		return record

module.exports =  AbstractProcessingHandler