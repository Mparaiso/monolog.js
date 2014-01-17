"use strict"

Abstractprocessinghandler = require './AbstractProcessingHandler'

class TestHandler extends Abstractprocessinghandler

	constructor:->
		super
		@records = []

	write:(record)->
		@records.push(record)