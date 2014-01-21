"use strict"
Abstractprocessinghandler = require './AbstractProcessingHandler'

#MongoDBHandler
class MongoDBHandler extends Abstractprocessinghandler

	###
		@param  {MongoClient} @mongodb    
		@param  {String} @collection 
		@param  {Number} level=100  
		@param  {Boolean} bubble=true 
	###
	constructor:(@mongodb,@collection="log",level=100,bubble=true)->
		super(level,bubble)

	write:(record,cb)->
		@mongodb.collection(@collection).insert record,(err,res)=>
			return cb(err,res,record,this)
		return @bubble

module.exports = MongoDBHandler
