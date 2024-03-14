import Toybox.Graphics;
import Toybox.WatchUi;
using Toybox.System;
import Toybox.Lang;
using Toybox.Communications;

class garmin_dogView extends WatchUi.View {

    var image;
    var responseCode;

    function responseCallback(
        responseCode as Number,
        data as WatchUi.BitmapResource or Graphics.BitmapReference or Null
    ) {
        responseCode = responseCode;
        if (responseCode == 200) {
            System.println("img response success " + data);
            image = data;
        } else {
            System.println("http response fail " + responseCode + " " + data);
            image = null;
        }
    }

    function makeImgRequest() {
        var url = "https://dummyimage.com/100x100/8c318c/b6b8cf.gif&text=asdf";           // set the image url
        var options = {  
            :dithering => Communications.IMAGE_DITHERING_NONE   // set the dithering
        };

        // Make the image request
        Communications.makeImageRequest(url, {}, options, method(:responseCallback));
    }

    ///////////////////


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

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
        makeImgRequest();
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

}
