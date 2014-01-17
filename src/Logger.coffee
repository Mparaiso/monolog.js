"use strict"

class Logger 

	@DEBUG=100
	@INFO=200
	@NOTICE=250
	@WARNING=300
	@ERROR=400
	@CRITICAL=500
	@ALERT=550
	@EMERGENCY=600
	@API=1
	@levels=
		100:'DEBUG'
		200:'INFO'
		250:'NOTICE'
		300:'WARNING'
		400:'ERROR'
		500:'CRITICAL'
		550:'ALERT'
		600:'EMERGENCY'

	constructor:(@name="",@handlers=[],@processors=[])->
	getName:->@name
	pushHandler:(handler)->@handlers.unshift(handler)
	popHandler:->@handlers.pop()
	pushProcessor:(processor)->@processors.unshift(processor)
	popProcessor:->@processors.pop()
	addRecord:(level,message,context)->
		#add a log record
		record=
			message:message
			context:context
			level:level
			level_name:Logger.levels[level] or 100
			channel:@name
			datetime: new Date
			extra:[]
		handlerKey = null
		for handler,i in @handlers
			if(handler.isHandling(record)) then handlerKey = i ; break

		if handlerKey is null then return false
		record = processor(record) for processor in @processors

		while @handlers[handlerKey] and false == @handlers[handlerKey].handle(record)
			handlerKey++
		true
	debug:(message,context)->
		@addRecord(Logger.DEBUG,message,context)
	info:(message,context)->
		@addRecord(Logger.INFO,message,context)
	notice:(message,context)->
		@addRecord(Logger.NOTICE,message,context)
	warning:(message,context)->
		@addRecord(Logger.WARNING,message,context)
	error:(message,context)->
		@addRecord(Logger.ERROR,message,context)
	crititcal:(message,context)->
		@addRecord(Logger.CRITICAL,message,context)
	alert:(message,context)->
		@addRecord(Logger.ALERT,message,context)
	emergency:(message,context)->
		@addRecord(Logger.EMERGENCY,message,context)
	isHandling:(level)->
		### Checks whether the Logger has a handler that listens on the given level ###
		record={level}
		@handlers.some (handler)->handler.isHandling(record)
	log:(level,message,context)->
		### Adds a log record at an arbitrary level. ###
		if typeof(level) is "string" then level = Logger[level] 
		@addRecord(level,message,context)
	crit:@::critical
	err:@::error
	emer:@::emergency
		
#
module.exports = Logger

