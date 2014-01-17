"use strict"

class FormatterInterface
	# Formats a log record.
	format:(record)->
	# Formats a set of log records.
	formatBatch:(records)->

module.exports = FormatterInterface