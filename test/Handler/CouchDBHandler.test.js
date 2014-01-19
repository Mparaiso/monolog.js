/*global describe,it,beforeEach*/
"use strict";

var monolog=require('../../index');
var assert=require('assert');
var stream=require('stream');
var http=require('http');

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
			done();
		});

	});
});
