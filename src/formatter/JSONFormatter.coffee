"use strict"

AbstractFormatter = require "./AbstractFormatter"

class JSONFormatter extends AbstractFormatter

	format:(record)->
		level:record.level
		level_name:record.level_name
		channel:record.channel
		datetime:record.date
		message:record.message
		extra:record.extra
		context:record.context

module.exports = JSONFormatter