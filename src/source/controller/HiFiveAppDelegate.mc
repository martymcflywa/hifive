using Toybox.WatchUi;

class HiFiveAppDelegate extends WatchUi.BehaviorDelegate {

  function initialize() {
    BehaviorDelegate.initialize();
  }

  function onMenu() {
    WatchUi.pushView(new Rez.Menus.MainMenu(), new HiFiveAppMenuDelegate(), WatchUi.SLIDE_UP);
    return true;
  }
}