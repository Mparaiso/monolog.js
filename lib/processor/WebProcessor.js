// Generated by CoffeeScript 1.6.3
var WebProcessor;

WebProcessor = (function() {
  function WebProcessor(server) {
    /*
    			@type {monolog.processor.Callback}
    			@param {Object} record
    			@return {Object} record
    */

    var F;
    F = function(record) {
      if (record.extra == null) {
        record.extra = {};
      }
      record.extra.url = F.request.url;
      record.extra.method = F.request.method;
      record.extra.server = F.request.headers.host;
      record.extra.referrer = F.request.referrer;
      record.extra.ip = F.request.headers['x-forwarded-for'] || F.request.connection.remoteAddress;
      return record;
    };
    F.server = server;
    F.server.on('request', function(req, res) {
      return F.request = req;
    });
    return F;
  }

  return WebProcessor;

})();

module.exports = WebProcessor;

/*
//@ sourceMappingURL=WebProcessor.map
*/
