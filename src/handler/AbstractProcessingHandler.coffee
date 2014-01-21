AbstractHandler = require './AbstractHandler'

class AbstractProcessingHandler extends AbstractHandler
	
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

	# writes a record
	# @param  {monolog.Record} record 
	# @param  {Function} cb     
	# @return {Boolean}         
	write:(record,cb)->
		cb(undefined,undefined,record,this) if cb instanceof Function
		@bubble

module.exports =  AbstractProcessingHandler