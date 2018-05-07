"use strict";

var vega = require('vega-lib');
var vegaEmbed = require('vega-embed');

exports.embed = function(sel) {
  return function (chart) {
    return function (opts) {
      return function (f) {
        return function () {
          return vegaEmbed(sel, chart, opts).then(function(res) {
            return f(res.view)();
          });
        };
      };
    };
  };
};

