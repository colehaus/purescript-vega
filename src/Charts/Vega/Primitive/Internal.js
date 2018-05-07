"use strict";

var vega = require('vega-lib');
var vegaEmbed = require('vega-embed');

exports.removeData = function(dataName) {
  return function(remove) {
    return function(view) {
      return function() {
        return view.change(dataName, vega.changeSet().remove(remove)).run();
      };
    };
  };
};

exports.insertData = function(dataName) {
  return function(insert) {
    return function(view) {
      return function() {
        return view.change(dataName, vega.changeset().insert(insert)).run();
      };
    };
  };
};

exports.insertAndRemoveData = function(dataName) {
  return function(insert) {
    return function(remove) {
      return function(view) {
        return function() {
          return view.change(dataName, vega.changeset().insert(insert).remove(remove)).run();
        };
      };
    };
  };
};
