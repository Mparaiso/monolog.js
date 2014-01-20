_ = require 'underscore'

# get datas from express request
class ExpressProcessor

	###
		@param  {Express} express 
		@return {Function}  
	###
	constructor:(express)->
		###
			processor
			@param {monolog.Record} record 
		 	@return {monolog.Record} [description]
		###
		F = (record)->
			record.extra ?= {}
			_.extend(record.extra,F.request)
			return record
		F.request = {}
		F.express = express
		express.use (req,res,next)->
			F.request = 
				params:req.params
				query:req.query
				body:req.body
				files:req.files
				route:req.route
				cookies:req.cookies
				signedCookies:req.signedCookies
				ip:req.id
				path:req.path
				host:req.host
				fresh:req.fresh
				stale:req.stale
				xhr:req.xhr
				protocole:req.protocol
				secure:req.secure
			next()
		return F