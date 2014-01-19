/*global describe,it,before,beforeEach*/
"use strict";
require('source-map-support').install();
var monolog = require('../../index'),
	StreamHandler = monolog.handler.StreamHandler,
	LineFormatter = monolog.formatter.LineFormatter,
	assert = require('assert'),
	expect = require('chai').expect,
	fs = require('fs');

describe('monolog.handler.StreamHandler', function() {
	beforeEach(function() {
		this.LineFormatter = new LineFormatter();
		this.filename = "stream.log";
		try {
			fs.unlinkSync(this.filename);
		} catch (ignore) {}
		this.streamHandler = new StreamHandler(this.filename,100);
		this.streamHandler.setFormatter(this.LineFormatter);
		this.record = {
			message: {
				foo: "bar"
			},
			context: undefined,
			level: 100,
			level_name: "DEBUG",
			channel: "baz",
			datetime: new Date(),
			extra: []
		};
	});
	it('should log in a file', function(done) {
		var file, self = this;
		assert(this.streamHandler.getFormatter());
		var cb = function(err, res,record, handler) {
			assert(!err);
			file = fs.readFileSync(self.filename, {
				encoding: "utf-8"
			});
			expect(file).to.contain(record.formatted);
			done();
		};
		this.streamHandler.handle(this.record, cb);
	});
	it('should log in a file stream', function(done) {
		var self = this,
			_stream = fs.createWriteStream(this.filename, {
				flag: "a"
			});
		var cb = function(err, res,record, handler) {
			assert.equal(handler, self.streamHandler);
			var file = fs.readFileSync(self.filename, {
				encoding: "utf-8"
			});
			expect(file).to.contain(record.formatted);
			done();
		};
		this.streamHandler.stream = _stream;
		this.streamHandler.handle(this.record, cb);
	});
	it('should log in the std outstream', function(done) {
		var _stream = process.stdout;
		this.streamHandler.stream = _stream;
		this.streamHandler.handle(this.record, done);
	});
});