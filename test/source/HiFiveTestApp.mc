using Toybox.Application;
using Toybox.WatchUi;

class HiFiveTestApp extends Application.AppBase {

  function initialize() {
    AppBase.initialize();
  }

  // Return the initial view of your application here
  function getInitialView() {
    return [new HiFiveTestView()];
  }
}
