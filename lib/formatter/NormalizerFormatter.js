// Generated by CoffeeScript 1.6.3
var AbstractFormatter, NormalizerFormatter, util, _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

AbstractFormatter = require('./AbstractFormatter');

util = require('util');

/*
 * Normalizes incoming records to remove objects/resources 
 * so it's easier to dump to various targets
*/


NormalizerFormatter = (function(_super) {
  __extends(NormalizerFormatter, _super);

  function NormalizerFormatter() {
    _ref = NormalizerFormatter.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  NormalizerFormatter.prototype.format = function(record) {
    return this.normalize(Object.create(record));
  };

  NormalizerFormatter.prototype.normalize = function(record) {
    var key, value;
    for (key in record) {
      value = record[key];
      record[key] = this.doNormalize(value);
    }
    return record;
  };

  NormalizerFormatter.prototype.doNormalize = function(data) {
    var _ref1;
    if ((_ref1 = typeof data) === 'string' || _ref1 === 'number' || _ref1 === 'function' || _ref1 === 'boolean') {
      return data.toString();
    } else if (data instanceof Date) {
      return util.format('%s-%s-%s %s:%s:%s', data.getFullYear(), data.getMonth() + 1, data.getDate(), data.getHours(), data.getMinutes(), data.getSeconds());
    } else if (data === null || data === void 0) {

    } else {
      return data.toString() + " ( " + JSON.stringify(data) + " ) ";
    }
  };

  return NormalizerFormatter;

})(AbstractFormatter);

module.exports = NormalizerFormatter;

/*
//@ sourceMappingURL=NormalizerFormatter.map
*/