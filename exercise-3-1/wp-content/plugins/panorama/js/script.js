var backgroundPos = 0;
var down = false;
var clickPosition;
var animate = true;
var direction = 0; //0 = right; 1 = left;

var speed, amplitude;
var ticker;

var mousedownTimestamp;
var mouseupTimestamp;
var mousedownLocation;
var mouseupLocation;
var positionRef;
var target;
var timeConst = 325;


    var resizePanoramaAndFrame = function () {
        $("#panorama-div").css('background-position-x', backgroundPos + '%');
        var move=resizeWindow();
        $("#black-frame").css("left", move + 'px');  
    }

    var resizeWindow = function () {
        var smallWidth = $("#small-image").width();
        var smallHeight = $("#small-image").height();
        var panoramaWidth = $("#panorama-div").width();
        var panoramaHeight = $("#panorama-div").height();
        $('#moving-canvas').width(panoramaWidth);
        $('#moving-canvas').height(panoramaHeight);
        var borderWidth = $("#black-frame").css("border-width")
        var scale = panoramaHeight / 1333.0;
        var percentageShown = panoramaWidth / (6000.0 * scale);
        var position = (backgroundPos / 100.0) * smallWidth * (1.0 - percentageShown);
        $("#black-frame").css("height", smallHeight - 6);
        $("#black-frame").css("width", smallWidth * percentageShown - 6);
        return position;
    }

$(document).ready(function () {
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
            var move=resizeWindow();
            $("#panorama-div").animate({ 'background-position-x': backgroundPos + '%' }, 100, function () {
                requestAnimationFrame(animateImg);
                $("#black-frame").css("left", move + 'px');
            });

            //console.log("animating: " + direction + " " + backgroundPos + " " + smallWidth + " " + smallHeight + " " + panoramaWidth + " " + panoramaHeight + " " + scale + " " + percentageShown);

        }
    }

    var track = function() {
    	var ts = Date.now();
    	var timeDiff = ts - mousedownTimestamp;
    	mousedownTimestamp = ts;

    	var spaceDiff = backgroundPos - positionRef;
    	positionRef = backgroundPos;

    	var v = 1000*spaceDiff / (1 + timeDiff);
    	speed = 0.8 * v + 0.2 * speed;
    }

    var momentum = function() {
    	var timeDiff, spaceDiff;
    	if (amplitude != 0) {
    		timeDiff = Date.now() - mouseupTimestamp;
    		spaceDiff = -amplitude * Math.exp(-timeDiff/timeConst);
    		if (spaceDiff > 0.5 || spaceDiff < -0.5) {
	            backgroundPos = target + spaceDiff;
	            if (backgroundPos > 100) backgroundPos = 100;
	            if (backgroundPos < 0) backgroundPos = 0;
	            resizePanoramaAndFrame();
	            requestAnimationFrame(momentum);
	        } else {
	            backgroundPos = target;
	            if (backgroundPos > 100) backgroundPos = 100;
	            if (backgroundPos < 0) backgroundPos = 0;
	            resizePanoramaAndFrame();
	        }
    	}
    }

    $("#panorama-div").mousedown(function (e) {
        clickPosition = e.pageX;
        down = true;
        animate = false;

        positionRef = backgroundPos;

        speed = 0;
        amplitude = 0;
	    mousedownTimestamp = Date.now();
	    clearInterval(ticker);
	    ticker = setInterval(track, 100);

        console.log("down: " + clickPosition);
    });

    $("#panorama-div").mouseup(function (e) {
        down = false;
        positionRef = backgroundPos;

        clearInterval(ticker);

        //if (speed > 1 || speed < -1) {
	        amplitude = 0.8 * speed;
	        target = Math.round(positionRef + amplitude);
	        mouseupTimestamp = Date.now();
	        requestAnimationFrame(momentum);
	    //}
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

            resizePanoramaAndFrame();  

            console.log("Mouse move called");          
        }
    });

    $("#small-image-wrapper").mousedown(function (e) {
        if (animate == true) {
            animate = false;
            return;
        }
        var clickPos = e.pageX;
        var startImage = $("#small-image").position().left;
        var smallImageWidth = $("#small-image").width();
        var endImage = startImage + smallImageWidth;
        if (clickPos > startImage && clickPos < endImage) {
            var offsetInsideSmallImage = clickPos - startImage;
            var offsetPercentage = 100 * offsetInsideSmallImage / smallImageWidth;
            //animate = false;
            console.log("Animate: " + animate);
            console.log("Down: " + down);
            console.log("backgroundPos: " + backgroundPos);
            backgroundPos = offsetPercentage;
            resizePanoramaAndFrame();            
        }
    })

    $(window).resize(function () {
        resizePanoramaAndFrame()
        var move=resizeWindow();
        $("#black-frame").css("left", move + 'px');
        //console.log("resize");
    });

    requestAnimationFrame(animateImg);
});        //end ready

var animationStopped=false;
var timer;
$.touch.triggerMouseEvents = false;
$.touch.preventDefault = false;
$.touch.ready(function() {
	$('#panorama-div').touchable({

		touchMove: function(e, touchHistory) {
            if(!animationStopped){
                animationStopped=true;
                animate=false;
                resizePanoramaAndFrame();  
            }
            $.touch.preventDefault = true;
            window.clearInterval(timer);
            timer=setInterval(function(){$.touch.preventDefault = false;},100);            
			var swipeLen=touchHistory.get(0).clientX-e.clientX;
            backgroundPos+=swipeLen/5.0;
            if (backgroundPos > 100) backgroundPos = 100;
            if (backgroundPos < 0) backgroundPos = 0;
            resizePanoramaAndFrame();  
            console.log("Touch move called");
		},
		touchUp: function(e, touchHistory) {
            if(!animationStopped){
                animationStopped=true;
                animate=false;
                resizePanoramaAndFrame();  
            }
		},
	});

	/*function message(s) {
		$('#moving-coordinates').html(s);
	}*/
});
