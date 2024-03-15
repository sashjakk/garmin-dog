import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Timer;
import Toybox.Lang;

class OfflineVideoView extends WatchUi.View {
    var imgs = [];
    var myTimer;
    var drawId = 0;

    function initialize() {
        View.initialize();

        myTimer = new Timer.Timer();
        myTimer.start(method(:doUpdate), 100, true);
    }

    function onLayout(dc as Dc) as Void {
        var drawables = [ Rez.Drawables.frame_001, Rez.Drawables.frame_002, Rez.Drawables.frame_003, Rez.Drawables.frame_004, Rez.Drawables.frame_005, Rez.Drawables.frame_006, Rez.Drawables.frame_007, Rez.Drawables.frame_008, Rez.Drawables.frame_009, Rez.Drawables.frame_010, Rez.Drawables.frame_011, Rez.Drawables.frame_012, Rez.Drawables.frame_013, Rez.Drawables.frame_014, Rez.Drawables.frame_015, Rez.Drawables.frame_016, Rez.Drawables.frame_017, Rez.Drawables.frame_018, Rez.Drawables.frame_019, Rez.Drawables.frame_020, Rez.Drawables.frame_021, Rez.Drawables.frame_022, Rez.Drawables.frame_023, Rez.Drawables.frame_024, Rez.Drawables.frame_025, Rez.Drawables.frame_026, Rez.Drawables.frame_027, Rez.Drawables.frame_028, Rez.Drawables.frame_029, Rez.Drawables.frame_030, Rez.Drawables.frame_031, Rez.Drawables.frame_032, Rez.Drawables.frame_033, Rez.Drawables.frame_034, Rez.Drawables.frame_035, Rez.Drawables.frame_036, Rez.Drawables.frame_037];
        for(var i=0; i<drawables.size(); i++) {
            imgs.add(Application.loadResource( drawables[i] ) as BitmapResource);
        }
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {}

    function doUpdate() {
        WatchUi.requestUpdate();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        // View.onUpdate(dc);

        render(dc);
    }

    function render(dc as Dc) {
        if (imgs[drawId] == null) {
            return;
        }
        
        dc.drawBitmap(
            dc.getWidth() / 2 - 227,
            dc.getHeight() / 2 - 227,
            imgs[drawId]
        );

        drawId = (drawId + 1) % imgs.size();
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
        myTimer.stop();
    }

    function leftpad3(i as Number) as String {
        var str = "" + (i % 1000);
        if (str.length() == 1) {
            return "00" + str;
        } else if(str.length() == 2) {
            return "0" + str;
        } else {
            return str;
        }
    }
}