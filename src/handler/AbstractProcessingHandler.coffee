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

	write:(record,cb)->
		cb(undefined,undefined,record,this) if cb instanceof Function

	processRecord:(record)->
		if @processors
			for processor in @processors     
				record = processor(record)
		return record

module.exports =  AbstractProcessingHandler