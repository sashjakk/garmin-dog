import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Timer;
import Toybox.Lang;

class OfflineVideoView extends WatchUi.View {
    
    var frameId as Number = 1;
    var frame as Graphics.BitmapResource or Null;

    var frames;

    var timer;

    function initialize() {
        View.initialize();
        
        frames = [
           Rez.Drawables.frame_0001,
           Rez.Drawables.frame_0002, 
           Rez.Drawables.frame_0003,
           Rez.Drawables.frame_0004, 
           Rez.Drawables.frame_0005, 
           Rez.Drawables.frame_0006,
           Rez.Drawables.frame_0007, 
           Rez.Drawables.frame_0008, 
           Rez.Drawables.frame_0009, 
           Rez.Drawables.frame_0010
        ];
    }

    function onShow() {
        timer = new Timer.Timer();
        timer.start(method(:requestFrame), 500, true);
    }

    function onUpdate(dc as Dc) as Void {
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
        dc.clear();
        
        if (frame == null) {
            return;
        }
        
        var x = (dc.getWidth() - frame.getWidth()) / 2;
        var y = (dc.getHeight() - frame.getHeight()) / 2;
        dc.drawBitmap(x, y, frame);
    }

    function requestFrame() {
        frame = WatchUi.loadResource(frames[frameId]);

        frameId = (frameId % (frames.size() - 1)) + 1;

        WatchUi.requestUpdate();
    }
}