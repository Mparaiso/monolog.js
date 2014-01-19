/*global describe,beforeEach,it*/
"use strict";
var sinon,monolog,assert;
assert=require('assert');
monolog=require('../../index');

describe('monolog.processor.WebProcessor',function(){
	beforeEach(function(){
		var self=this;
		this.request = {method:"GET",headers:{},connection:{}};
		this.server = {
			on:function(event,callback){
				callback(self.request);
			}
		};
		this.WebProcessor = new monolog.processor.WebProcessor(this.server);
		this.record = {};
	});
	it('() should add the right data to record ',function(){
		this.WebProcessor(this.record);
		assert(this.record.extra.method,this.request.method);
	});
});