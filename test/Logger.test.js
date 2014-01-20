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
});