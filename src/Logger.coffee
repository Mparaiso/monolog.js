"use strict"
util = require 'util'
events = require 'events'
###
	Monolog log channel

	It contains a stack of Handlers and a stack of Processors.
	and uses them to kstore records that are added to it.
###
class Logger 

	util.inherits(Logger,events.EventEmitter)

	@LOG="log"
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
	pushHandler:(handler)->@handlers.unshift(handler);this
	popHandler:->@handlers.pop()
	pushProcessor:(processor)->@processors.unshift(processor);this
	popProcessor:->@processors.pop()
	#add a log record
	addRecord:(level,message,context)->
		record=
			message:message
			context:context
			level:level
			level_name:Logger.levels[level] or 100
			channel:@name
			datetime: new Date
			extra:{toString:->'[object Extra]'}
		handlerKey = null
		for handler,i in @handlers
			if(handler.isHandling(record)) then handlerKey = i ; break

		if handlerKey is null then return false
		record = processor(record) for processor in @processors

		while @handlers[handlerKey] and false == @handlers[handlerKey].handle(record,(err,res,record,handler)=>@emit(Logger.LOG,err,res,record,handler))
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
	critical:(message,context)->
		@addRecord(Logger.CRITICAL,message,context)
	alert:(message,context)->
		@addRecord(Logger.ALERT,message,context)
	emergency:(message,context)->
		@addRecord(Logger.EMERGENCY,message,context)

	# Checks whether the Logger has a handler that listens on the given level 
	isHandling:(level)->
		record={level}
		@handlers.some (handler)->handler.isHandling(record)

	# Adds a log record at an arbitrary level. ###
	log:(level,message,context)->
		if typeof(level) is "string" then level = Logger[level] 
		@addRecord(level,message,context)
	crit:@::critical
	err:@::error
	emer:@::emergency
	warn:@::warning
	addProcessor:@::pushProcessor
	addHandler:@::pushHandler

module.exports = Logger

