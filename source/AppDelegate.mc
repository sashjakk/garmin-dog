import Toybox.Lang;
import Toybox.WatchUi;

class AppDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        var menu = new WatchUi.Menu2({
            :title => "Select Video"
        });

        menu.addItem(new MenuItem("Online", null, "online", null));
        menu.addItem(new MenuItem("Offline", null, "offline", null));
        
        WatchUi.pushView(menu, new MenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}