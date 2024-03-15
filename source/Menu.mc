import Toybox.WatchUi;

function makeMenu() {
    var menu = new WatchUi.Menu2({
        :title => "Select Video"
    });

    menu.addItem(new MenuItem("Online", null, "online", null));
    menu.addItem(new MenuItem("Offline", null, "offline", null));
        
    return menu;
}