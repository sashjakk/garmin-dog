import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;
import Toybox.Lang;
import Toybox.Communications;
import Toybox.Timer;

class garmin_dogView extends WatchUi.View {
    static const FRAME_COUNT = 60;

    var frameId as Number = 1;
    var frame as Graphics.BitmapReference or Null;

    function onShow() {
        requestFrame();
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

    function onResponse(
        code as Number,
        data as WatchUi.BitmapResource or Graphics.BitmapReference or Null
    ) {
        System.println("[http] code: " + code + ", frame id: " + frameId + ", data: " + data + "\n");

        if (code == 200) {
            frame = data;
            WatchUi.requestUpdate();
        }

        requestFrame();
    }
    
    function requestFrame() {
        var url = Lang.format(
            "https://raw.githubusercontent.com/sashjakk/garmin-dog/main/images/frame_$1$.jpg", 
            [frameId.format("%04d")]
        );

        var options = {  
            :dithering => Communications.IMAGE_DITHERING_NONE
        };

        System.println("[http] frame id: " + frameId + ", url: " + url);

        Communications
            .makeImageRequest(url, {}, options, method(:onResponse));

        frameId = (frameId % garmin_dogView.FRAME_COUNT) + 1;
    }
}