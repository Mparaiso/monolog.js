Formatterinterface = require './FormatterInterface'
util = require 'util'
###
 * Normalizes incoming records to remove objects/resources 
 * so it's easier to dump to various targets
###
class NormalizerFormatter extends Formatterinterface

	format:(record)->
		@normalize(Object.create(record))

	formatBatch:(records)->
		@format(record)  for record in records

	normalize:(record)->
		record[key]=@doNormalize(value) for key,value of record 
		return record
			
	doNormalize:(data)->
		if typeof data in ['string','number','function','boolean']
			data.toString()
		else if data instanceof Date 
			util.format('%s-%s-%s %s:%s:%s',data.getFullYear(),data.getMonth()+1,data.getDate(),data.getHours(),data.getMinutes(),data.getSeconds())
		else if data is null or data is undefined
		else data.toString() + " ( " + JSON.stringify(data) + " ) "

module.exports = NormalizerFormatter