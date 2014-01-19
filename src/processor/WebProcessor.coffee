
# Injects url/method and remote IP of the current web request in all records
class WebProcessor
	# @param {http.Server} server
	# @return {monolog.processor.Callback}
	constructor:(server)->
		###
			@type {monolog.processor.Callback}
			@param {Object} record
			@return {Object} record
		###
		F = (record)->
			record.extra ?= {}
			record.extra.url = F.request.url
			record.extra.method = F.request.method
			record.extra.server = F.request.headers.host
			record.extra.referrer = F.request.referrer
			record.extra.ip = F.request.headers['x-forwarded-for']||F.request.connection.remoteAddress
			return record
		F.server = server
		F.server.on 'request',(req,res)->
			F.request = req 

		return F

module.exports = WebProcessor