$(document).ready(function () {
    var backgroundPos = 0;
    var down = false;
    var clickPosition;
    var animate = true;
    var direction = 0; //0 = right; 1 = left;

    var animateImg = function () {
        //console.log("load was called");
        if (animate) {
            if (direction == 0) backgroundPos++;
            else backgroundPos--;
            if (direction == 0 && backgroundPos > 100) {
                backgroundPos = 100;
                direction = 1;
            }
            if (direction == 1 && backgroundPos < 0) {
                backgroundPos = 0;
                direction = 0;
            }
            var smallWidth = $("#small-image").width();
            var smallHeight = $("#small-image").height();
            var panoramaWidth = $("#panorama-div").width();
            var panoramaHeight = $("#panorama-div").height();
            var borderWidth = $("#black-frame").css("border-width")
            var scale = panoramaHeight / 1333.0;
            var percentageShown = panoramaWidth / (6000.0 * scale);
            $("#black-frame").css("height", smallHeight - 6);
            $("#black-frame").css("width", smallWidth * percentageShown);
            $("#panorama-div").animate({ 'background-position-x': backgroundPos + '%' }, 100, function () {
                animateImg();
                $("#black-frame").css("left", backgroundPos + '%');
            });
           
            //console.log("animating: " + direction + backgroundPos + " " + smallWidth + " " + smallHeight + " " + panoramaWidth + " " + panoramaHeight+" "+scale+" "+percentageShown);
            
        }
    }

    $("#panorama-div").mousedown(function (e) {
        clickPosition = e.pageX;
        down = true;
        animate = false;
        //console.log("down: " + clickPosition);
    });

    $("#panorama-div").mouseup(function (e) {
        down = false;
        //console.log("up: " + clickPosition);
    });

    $("#panorama-div").mouseout(function (e) {
        down = false;
        //console.log("out: " + clickPosition);
    });

    $("#panorama-div").mousemove(function (e) {
        if (down) {
            var newPosition = e.pageX;
            var dif = clickPosition - newPosition;
            clickPosition = newPosition;
            backgroundPos += dif / 10;
            if (backgroundPos > 100) backgroundPos = 100;
            if (backgroundPos < 0) backgroundPos = 0;

            $("#panorama-div").css('background-position-x', backgroundPos + '%');
            $("#black-frame").css("left", backgroundPos + '%');
            //console.log("move: " + backgroundPos);
        }
    });

    animateImg();
});     //end ready