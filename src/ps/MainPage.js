
// module MainPage

exports.pushPageImpl = function (navId) {
  return function (pageId) {
    return function (error, success) {
      var nav = document.querySelector(navId);
      var lastTopPage = document.querySelector(pageId);
      nav._pushPage({lastTopPage: lastTopPage}).then(success);
      return function (cancelError, cancelerError, cancelerSuccess) {
        cancelerSuccess();
      };
    };
  };
};

exports.popPageImpl = function (navId) {
  return function (error, success) {
    var nav = document.querySelector(navId);
    nav._popPage({ }).then(success);
    return function (cancelError, cancelerError, cancelerSuccess) {
      cancelerSuccess();
    }
  }
}