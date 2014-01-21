/*global describe,it,beforeEach*/
"use strict";

var monolog = require('../index');
var assert = require('assert');
var expect = require('chai').expect;

describe('monolog', function() {
	describe('.create', function() {
		beforeEach(function() {
			this.name = 'test logger';
			this.logger = monolog.create(this.name);
		});

		it('should be an instance of monolog.Logger', function() {
			assert(this.logger instanceof monolog.Logger);
		});
		it('should have the correct name', function() {
			assert.equal(this.logger.getName(), this.name);
		});
	});
});