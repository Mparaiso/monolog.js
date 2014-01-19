"use strict"

Abstractprocessinghandler = require './AbstractProcessingHandler'
stream = require 'stream'
fs = require 'fs'

#Stores to any stream resource
#
#Can be used to store into stderr, remote and local files, etc.
class StreamHandler extends Abstractprocessinghandler

	# @param {String}  stream
    # @param {Number} level  The minimum logging level at which this handler will be triggered
    # @param {Boolean} bubble Whether the messages that are handled can bubble up the stack or not
	constructor:(_stream,level=100,bubble=true)->
		super(level,bubble)
		if _stream instanceof stream.Stream
			@stream=_stream
		else
			@url=_stream

	# {@inheritdoc}
	write:(record,cb)->
		if(@stream is undefined)
			if(@url == null)
				cb(new Error('Missing stream url')) if cb instanceof Function
			else
				fs.writeFile(@url,record.formatted,{flag:"a"},(err,res)=>cb(err,res,record,this))
		else
			@stream.write(record.formatted,(err,res)=>cb(err,res,record,this))

module.exports = StreamHandler