$(document).ready(function(){
	var backgroundPos = 0;
	var down = false;
	var clickPosition;

	$("#panorama-div").mousedown(function(e) {
		clickPosition = e.pageX;
		down = true;

		console.log("down: " + clickPosition);
	});

	$("#panorama-div").mouseup(function(e) {
		down = false;
		console.log("up: " + clickPosition);
	});

	$("#panorama-div").mouseout(function(e) {
		down = false;
		console.log("up: " + clickPosition);
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

			console.log("move: " + backgroundPos);
		}
	});


});//end ready