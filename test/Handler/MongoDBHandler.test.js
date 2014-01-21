/*global describe,it,beforeEach,before*/
"use strict";
var monolog, assert, stream, sinon, mongo, db;

monolog = require('../../index');
assert = require('assert');
mongo = require('mongodb');
sinon = require('sinon');



before(function(done) {
	mongo.MongoClient.connect(process.env.MONGODB_TEST || 'mongodb://travis:test@localhost/test', function(err, res) {
		if (err) {
			throw err;
		}
		db = res;
		done();
	});
});

describe("monolog.handler.MongoDBHandler", function() {
	beforeEach(function() {
		this.db = db;
		this.handler = new monolog.handler.MongoDBHandler(db);
		this.record = {
			level: 100,
			level_name: "DEBUG",
			message: "message",
			channel: "channel",
			datetime: new Date(),
			context: {},
			extra: {}
		};
	});
	describe('#handle', function() {
		it('should post log to mongodb database', function(done) {
			this.handler.handle(this.record, function(err, res) {
				assert(!err);
				assert(res);
				done();
			});
		});
	});
});