/*global describe,beforeEach,it*/
"use strict";
var app, monolog, ExpressProcessor, assert;

monolog = require('../../index');
ExpressProcessor = monolog.processor.ExpressProcessor;
assert = require('assert');
app = {
	use: function(func) {
		func({
			method: "GET"
		}, {}, function() {
			return;
		});
	}
};


describe("monolo.processor.ExpressProcessor", function() {
	beforeEach(function() {
		this.record = {};
		this.processor = new ExpressProcessor(app);
	});
	it('should execute and return the correct extra', function() {
		this.processor(this.record);
		assert.equal(this.record.extra.request.method, "GET");
	});
});