/*global describe,beforeEach,it*/
"use strict";
var monolog, assert, expect;

monolog = require('../../index');
assert = require('assert');
expect = require('chai').expect;

describe("monolog.formatter.LineFormatter", function() {
	beforeEach(function() {
		this.record = {
			channel: "log",
			level_name: "DEBUG",
			datetime: new Date(),
			message: "foo",
			context: {},
			extra: {}
		};
		this.formatter = new monolog.formatter.LineFormatter();
	});
	describe('format', function() {
		it('should format the record into a string', function() {
			var string = this.formatter.format(this.record);
			expect(string).to.contain(this.record.channel);
			expect(string).to.contain(this.record.level_name);
		});
	});
});