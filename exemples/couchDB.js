"use strict";
var monolog,logger;

monolog=require('./monolog');
logger = new monolog.Logger("couchdb logger");
logger.pushHandler(new monolog.handler.CouchDBHandler({
	host:"localhost",
	dbname:"logger"
}));
logger.on('log',function(err,res,record,handler){
	console.log(arguments);
});
logger.info('Logging to couchdb');