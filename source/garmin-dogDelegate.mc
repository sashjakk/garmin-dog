import Toybox.Lang;
import Toybox.WatchUi;

class garmin_dogDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new garmin_dogMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}