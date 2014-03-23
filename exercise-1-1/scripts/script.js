var backgroundPos = 0;
var down = false;
var clickPosition;
var animate = true;
var direction = 0; //0 = right; 1 = left;

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
                animateImg();
                $("#black-frame").css("left", move + 'px');
            });

            //console.log("animating: " + direction + " " + backgroundPos + " " + smallWidth + " " + smallHeight + " " + panoramaWidth + " " + panoramaHeight + " " + scale + " " + percentageShown);

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

            resizePanoramaAndFrame();            
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

    animateImg();
});        //end ready

var animationStopped=false;

$.touch.triggerMouseEvents = true;
$.touch.preventDefault = false;
$.touch.ready(function() {
	$('#moving-canvas').touchable({

		gesture: function(e, touchHistory) {
            //$.touch.preventDefault = true;
			var touches = $(this).touches();
				var th = touchHistory;
				th = th.stop({
					type: ['touchdown', 'touchup']
				});
				th = th.filter({
					type: 'touchmove',
					time: '1..100'
				});
				if (th.match({ deltaX: '<-100' })) {
					messageSwipe('swipe left');
				} else if (th.match({ deltaX: '>100' })) {
					messageSwipe('swipe right');
				 }
		},
		touchMove: function(e, touchHistory) {            
			var swipeLen=touchHistory.get(0).clientX-e.clientX;
			message(swipeLen);
            backgroundPos+=swipeLen/5.0;
            if (backgroundPos > 100) backgroundPos = 100;
            if (backgroundPos < 0) backgroundPos = 0;
            resizePanoramaAndFrame();  
            //$.touch.preventDefault = false;
		},
		touchUp: function(e, touchHistory) {
            if(!animationStopped){
                animationStopped=true;
                animate=false;
                resizePanoramaAndFrame();  
            }
		},
	});

	function messageSwipe(s) {
		$('#moving-coordinates').html(s);
	}

    function message(s) {
		$('#moving-coordinates').html(s);
	}
});
