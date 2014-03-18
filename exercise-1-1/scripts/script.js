$(document).ready(function(){
	var backgroundPos = 0;
	var down = false;
	var clickPosition;
	var animate = true;
	var direction = 0; //0 = right; 1 = left;

	var animateImg = function() {
		//console.log("load was called");
		if (animate) {
			//console.log("animating: " + direction + backgroundPos);
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
			$("#panorama-div").animate({'background-position-x': backgroundPos+'%'}, 100, function() {
				animateImg();
			});
		}
	}

	$("#panorama-div").mousedown(function(e) {
		clickPosition = e.pageX;
		down = true;
		animate = false;
		//console.log("down: " + clickPosition);
	});

	$("#panorama-div").mouseup(function(e) {
		down = false;
		//console.log("up: " + clickPosition);
	});

	$("#panorama-div").mouseout(function(e) {
		down = false;
		//console.log("out: " + clickPosition);
	});

	$("#panorama-div").mousemove(function(e) {
		if (down) {
			var newPosition = e.pageX;
			var dif = clickPosition - newPosition;
			clickPosition = newPosition;
			backgroundPos += dif/10;
			if (backgroundPos > 100) backgroundPos = 100;
			if (backgroundPos < 0) backgroundPos = 0;

			$("#panorama-div").css('background-position-x', backgroundPos+'%');

			//console.log("move: " + backgroundPos);
		}
	});
	
	animateImg();
});//end ready