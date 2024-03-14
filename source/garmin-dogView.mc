import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
import Toybox.Lang;
using Toybox.Communications;
using Toybox.Timer;

var imgId as Number = 0;
var maxImgCount = 10;

var myTimer;
var drawId = 0;
var startDraw = false;

class garmin_dogView extends WatchUi.View {

    var responseCode;

    function responseCallback(
        responseCode as Number,
        data as WatchUi.BitmapResource or Graphics.BitmapReference or Null
    ) {
        responseCode = responseCode;
        if (responseCode == 200) {
            var name = leftpad3(imgId);
            System.println("img response success: " + name);
            Application.Storage.setValue(name, data);
        } else {
            System.println("http response fail " + responseCode + " " + data);
        }

        imgId = imgId + 1;
        if (imgId < maxImgCount) {
            makeImgRequest();
        }
    }

    function makeImgRequest() {
        var url = "https://dummyimage.com/256x256/8c318c/b6b8cf.gif&text=" + leftpad3(imgId);           // set the image url
        var options = {  
            :dithering => Communications.IMAGE_DITHERING_NONE   // set the dithering
        };

        // Make the image request
        Communications.makeImageRequest(url, {}, options, method(:responseCallback));
    }

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        // setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        // makeImgRequest();

        myTimer = new Timer.Timer();
        myTimer.start(method(:doUpdate), 100, true);
    }

    function doUpdate() {
        WatchUi.requestUpdate();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        render(dc);
    

    }

    function render(dc as Dc) {
        var fromStorage = Application.Storage.getValue(leftpad3(drawId));
        dc.drawBitmap(
            dc.getWidth() / 2 - 128,
            dc.getHeight() / 2 - 128,
            fromStorage
        );

        drawId = (drawId + 1) % maxImgCount;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
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


// function onReceive(
    //     responseCode as Number,
    //     data as Dictionary<String, Object?> or String or Null
    // ) as Void {
    //     if (responseCode == 200) {
    //         System.println("http response success " + data);
    //     } else {
    //         System.println("http response fail");
    //     }
    // }

    // function makeRequest() {
    //    var url = "https://dummyjson.com/products/1";
    //    var options = {                                             // set the options
    //        :method => Communications.HTTP_REQUEST_METHOD_GET,      // set HTTP method
    //        :headers => { "Content-Type" => Communications.REQUEST_CONTENT_TYPE_URL_ENCODED },
    //                                                                // set response type
    //        :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
    //    };
    //    Communications.makeWebRequest(url, {}, options, method(:onReceive));
    // }