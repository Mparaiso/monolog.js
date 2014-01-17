Logger = require '../Logger'

class AbstractHandler
	### 
	 	Base Handler class providing the Handler structure
	###
	constructor:(@level=Logger.DEBUG,@bubble=true)->
		processors= []
	isHandling:(record)->
		record.level==@level
	handle:(record)->
	handleBatch:(records)->
		@handle(record) for record in records ; return
	close:->
	pushProcessor:(callback)->
		@processors.unshift(callback) if callback instanceof Function
	popProcessor:()->
		@processors.shift();return this
	setFormatter:(@formatter)->
	getFormatter:->@formatter
	setLevel:(@level)->
	getLevel:->@level
	setBubble:(@bubble)->
	getBubble:->@bubble

module.exports = AbstractHandler