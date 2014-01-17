/*global describe,it,before,beforeEach*/
"use strict";
require('source-map-support').install();
var monolog = require('../index')
	, Logger = monolog.Logger
	, ConsoleLogHandler = monolog.handler.ConsoleLogHandler
	, StreamHandler = monolog.handler.StreamHandler
	, LineFormatter = monolog.formatter.LineFormatter
	, assert = require('assert')
	, expect = require('chai').expect
	, fs = require('fs');

describe('monolog', function() {
	beforeEach(function(){
		this.loggerName = "logger";
		this.lineFormatter = new LineFormatter();
		this.logger = new Logger(this.loggerName);
	});
	describe('Logger', function() {
		beforeEach(function() {
			this.consoleLogHandler = new ConsoleLogHandler();
			this.consoleLogHandler.setFormatter(this.lineFormatter);
			this.logger.pushHandler(this.consoleLogHandler);
		});
		describe("", function() {
			it('should be named logger', function(done) {
				var self=this
					, message = {foo:"bar"};
				this.logger.on(Logger.LOG,function(handler,record){
					assert.equal(self.logger.getName(), self.loggerName);
					assert.equal(record.message,message);
					done();
				});
				this.logger.log(Logger.DEBUG,message);
			});
		});
	});

	describe('handler',function(){
		describe('StreamHandler',function(){
			beforeEach(function(){
				this.filename = "stream.log";
				try{
					fs.unlinkSync(this.filename);
				}catch(ignore){}
				this.streamHandler = new StreamHandler(this.filename);
				this.streamHandler.setFormatter(this.lineFormatter);
				this.logger.pushHandler(this.streamHandler);
			});
			it('should log in a file',function(done){
				var file,message = "foo",self=this;
				assert(this.streamHandler.getFormatter());
				this.logger.on(Logger.LOG,function(err,record,handler){
					assert(!err);
					file = fs.readFileSync(self.filename,{encoding:"utf-8"});
					expect(file).to.contain(message);
					done();
				});
				this.logger.log(Logger.DEBUG,message);
			});
			it('should log in a file stream',function(done){
				var message={foo:"bar"}
					,	self =this
					,	_stream= fs.createWriteStream(this.filename,{flag:"a"});
				this.logger.on('log',function(err,record,handler){
					console.log(arguments);
					//assert.equal(handler,self.streamHandler);
					var file = fs.readFileSync(self.filename,{encoding:"utf-8"});
					expect(file).to.contain(JSON.stringify(message));
					done();
				});
				this.streamHandler.stream = _stream;
				this.logger.log(Logger.INFO,message);
			});
		});
	});

});