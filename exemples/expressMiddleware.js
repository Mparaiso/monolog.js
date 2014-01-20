 "use strict";
 /**
  * monolog middleware for connect and express
  * USAGE
  * =====
  * var app=express()
  * app.use(logger.middleware(app,"debugging"));
  * 
  */
 var monolog = require('monolog');
 /**
  * @type {monolog.Logger}
  */
 var logger = new monolog.Logger("express logger");

 logger.addHandler(new monolog.handler.StreamHandler(__dirname + "/../temp/log.txt"));
 /**
  * [middleware description]
  * @param  {Express} app     express app
  * @param  {String} message log message
  * @return {Function}         middleware
  */
 logger.middleware = function(app, message) {
 	message = message || "debug";
 	logger.addProcessor(new monolog.processor.ExpressProcessor(app));
 	app.set('logger', logger);
 	var F =  function(req, res, next) {
 		logger.debug(message);
 		next();
 	};
 	F.logger = logger;
 	return F;
 };

 module.exports = logger;