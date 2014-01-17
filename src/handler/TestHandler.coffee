"use strict"

Abstractprocessinghandler = require './AbstractProcessingHandler'

class TestHandler extends Abstractprocessinghandler

	constructor:->
		super
		@records = []

	write:(record,cb)->
		@records.push(record)
		cb(undefined,record,handler) if cb instanceof Function