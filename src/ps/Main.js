var ons = require('onsenui');

exports.onsReadyImpl = function (_error, success) {
  ons.ready(function() { 
    success(); 
  });
  return function (_cancelError, _cancelerError, cancelerSuccess) {
    cancelerSuccess();
  };
};
