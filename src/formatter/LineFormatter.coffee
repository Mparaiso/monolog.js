"use strict"

util = require 'util'
_ = require 'underscore'
NormalizerFormatter = require './NormalizerFormatter'

class LineFormatter extends NormalizerFormatter

	@SIMPLE_FORMAT= _.template("[<%-datetime %>] <%-channel%>.<%-level_name%>: <%=message%> <%=context%> <%=extra%> \n")
	
	constructor:(@template=LineFormatter.SIMPLE_FORMAT)->

	format:(record)->
		vars= super(record)
		@template(vars)

	formatBatch:(records)->
		records.map((r)=>@format(r)).join()

module.exports = LineFormatter