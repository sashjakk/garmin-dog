import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

class MenuDelegate extends WatchUi.Menu2InputDelegate {

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onSelect(item as MenuItem) as Void {
        if (item.getId().equals("online")) {
            WatchUi.switchToView(new OnlineVideoView(), new AppDelegate(), WatchUi.SLIDE_DOWN);
            WatchUi.requestUpdate();
            return;
        }
        
        if (item.getId().equals("offline")) {
            WatchUi.switchToView(new OfflineVideoView(), new AppDelegate(), WatchUi.SLIDE_DOWN);
            WatchUi.requestUpdate();
            return;
        }
    }
}