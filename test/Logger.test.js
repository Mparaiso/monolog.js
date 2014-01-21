/*global describe,it,before,beforeEach*/
"use strict";
require('source-map-support').install();
var monolog = require('../index'),
	Logger = monolog.Logger,
	TestHandler = monolog.handler.TestHandler,
	StreamHandler = monolog.handler.StreamHandler,
	LineFormatter = monolog.formatter.LineFormatter,
	assert = require('assert'),
	expect = require('chai').expect,
	fs = require('fs'),
	sinon = require('sinon');

	describe('monolog', function() {
		beforeEach(function() {
			this.loggerName = "logger";
			this.lineFormatter = new LineFormatter();
			this.logger = new Logger(this.loggerName);
		});
		describe('Logger', function() {
			beforeEach(function() {
				this.handler = new TestHandler();
				this.logger.pushHandler(this.handler);
			});
			describe("#popHandler",function(){
				it('should remove last handler',function(){
					var handler = this.logger.popHandler();
					assert.equal(this.handler,handler);
				});
			});
			describe("#log", function() {
				it('should log messages correctly', function() {
					var cb, message;
					cb = sinon.spy();
					message = {
						foo: "bar"
					};
					this.logger.on(Logger.LOG,cb);
					this.logger.log(Logger.DEBUG, message);
					['debug','info','notice','warning','error','critical','alert','emergency']
						.forEach(function(verb){
							this.logger[verb](message);
						}, this);
					assert.equal(cb.callCount,9);
					assert.equal(this.handler.records.length,9);
				});
			});
		});
	});