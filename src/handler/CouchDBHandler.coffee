"use strict"
http = require 'http'
noop = ->
mixin = (target,objects...)->
	target[property] = object[property] for own property of object for object in objects
	return target

AbstractProcessingHandler = require './AbstractProcessingHandler'
JSONFormatter = require '../formatter/JSONFormatter'

# CouchDB handler
class CouchDBHandler extends AbstractProcessingHandler


	defaultOptions:
		host:'localhost'
		dbname:'logger'
		port:5984

	request:http.request

	#@param {Object} options
	#@option options {String} host
	#@option options {String} dbname
	#@option options {Number} port
	#@option options {String} username
	#@option options {String} password
	#@param {Number} level
	#@param {Boolean} bubble
	constructor:(options,level=100,bubble=true)->
		@options = mixin({},@defaultOptions,options)
		super(level,bubble)
		@formatter = new JSONFormatter

	getStreamOptions:->
		@_streamOptions ?= {
			hostname:@options.host
			method:"POST"
			port:if @options.port then @options.port else 80
			path:"/"+@options.dbname
			auth: if @options.username && @options.password then "#{@options.username}:#{@options.password}" else ""
			headers:
				"content-type":"application/json"
		}
		return @_streamOptions

	#@private
	write:(record,cb=noop)->
		
		r = @request @getStreamOptions(),(res)=>
			res.setEncoding('utf8');
			res.on 'data',(data)=>
				cb(undefined,data,record,this)

		r.on("error",(err,res)=>cb(err,res,record,this))
		r.end(JSON.stringify(record))
		return @bubble

module.exports = CouchDBHandler