/*global describe,it,beforeEach*/
"use strict";

var monolog = require('../../index');
var assert = require('assert');
var expect = require('chai').expect;

describe('monolog.handler.TestHandler', function() {
	beforeEach(function() {
		this.record = {
			message: "message",
			level: 100,
			level_name: "DEBUG",
			channel: "foo channel",
			context: {},
			extra: {},
			datetime: new Date()
		};
		this.handler = new monolog.handler.TestHandler();
	});
	describe('handle', function() {
		it('should write record to an array', function(done) {
			var cb = function(err, records, record, handler) {
				assert.equal(records.length, 1);
				expect(records[0]).to.contain(record.message);
				expect(records[0]).to.contain(record.level_name);
				done();
			};
			this.handler.handle(this.record,cb);

		});
	});
});