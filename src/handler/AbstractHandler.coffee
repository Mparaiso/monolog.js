Logger = require '../Logger'
LineFormatter = require '../formatter/LineFormatter'

class AbstractHandler
	### 
	 	Base Handler class providing the Handler structure
	###
	constructor:(@level=Logger.DEBUG,@bubble=true)->
		@processors= []

	###
	    Checks whether the given record will be handled by this handler.
		This is mostly done for performance reasons, to avoid calling processors for nothing.
		Handlers should still check the record levels within handle(), returning false in isHandling()
		is no guarantee that handle() will not be called, and isHandling() might not be called
		for a given record.
		@param {Array} record
		@return {Boolean}
	###
	isHandling:(record)->
		record.level>=@level
	###
		handle a record
		@param  {monolog.Record}   record 
		@param  {Function} cb     
		@return {Boolean}          
	###
	handle:(record,cb)->
		cb(undefined,undefined,record,this) if cb instanceof Function
		false
	###
		handle an array of records
		@param  {Array<Object>} records 
		@return {Boolean}      
	###
	handleBatch:(records)->
		@handle(record) for record in records ; return
	close:->
	pushProcessor:(callback)->
		@processors.unshift(callback) if callback instanceof Function
	popProcessor:()->
		@processors.shift();return this
	setFormatter:(@formatter)->
	getFormatter:->
		@formatter = if not @formatter  then new LineFormatter else @formatter
	setLevel:(@level)->
	getLevel:->@level
	setBubble:(@bubble)->
	getBubble:->@bubble

	processRecord:(record)->
		if @processors
			for processor in @processors     
				record = processor(record)
		return record

module.exports = AbstractHandler