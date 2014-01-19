"use strict"

class FormatterInterface
	# Formats a log record.
	format:(record)->
		throw "not implemented"
	# Formats a set of log records.
	formatBatch:(records)->
		records.map((r)=>@format(r)).join()

module.exports = FormatterInterface