/*global describe,it,beforeEach*/
"use strict";

var monolog=require('../../index');
var assert=require('assert');
var stream=require('stream');
var http=require('http');
var request=require('request');
describe('monolog.processor.CouchDBHandler',function(){
	beforeEach(function(){
		this.record={
			message:"logging to couchdb",
			extra:{},
			context:{},
			level:100
		};
		this.options={
			host:"localhost",
			dbname:"logger",
			port:5984
		};
		this.couchDBHandler= new monolog.handler.CouchDBHandler(this.options);
	});
	
	it('should write record in couchdb',function(done){
		this.couchDBHandler.handle(this.record,function(err,res){
			assert(!err);
			console.log(arguments);
			done();
		});

	});
});


/*
request({url:'http://aikah.iriscouch.com/logger'
	,method:'POST'
	,body:JSON.stringify({param:"value"})
	,headers:{
		"content-type":"application/json"
	}}
	,function(e,r,body){
	console.log(body);
	assert.equal(body.ok,true);
	assert(body.id);
	done();
});
*/