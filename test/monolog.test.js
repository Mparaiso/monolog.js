/*global describe,it,before,beforeEach*/
"use strict";
require('source-map-support').install();
var monolog = require('../index')
	, Logger = monolog.Logger
	, ConsoleLogHandler = monolog.handler.ConsoleLogHandler
	, LineFormatter = monolog.formatter.LineFormatter
	, assert = require('assert');

describe('monolog', function() {

	describe('Logger', function() {
		before(function() {
			this.loggerName = "logger";
			this.lineFormatter = new LineFormatter();
			this.consoleLogHandler = new ConsoleLogHandler();
			this.consoleLogHandler.setFormatter(this.lineFormatter);
			this.logger = new Logger(this.loggerName);
			this.logger.pushHandler(this.consoleLogHandler);
		});
		describe("", function() {
			it('should be named logger', function() {
				this.logger.log(Logger.DEBUG, {foo:"bar"});
				assert.equal(this.logger.getName(), this.loggerName);
			});
		});
	});
});