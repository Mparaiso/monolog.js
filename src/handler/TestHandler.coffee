"use strict"

Abstractprocessinghandler = require './AbstractProcessingHandler'

class TestHandler extends Abstractprocessinghandler

	constructor:->
		super
		@records = []

	write:(record,cb)->
		@records.push(record.formatted)
		cb(undefined,@records,record,this) if cb instanceof Function

module.exports=TestHandler