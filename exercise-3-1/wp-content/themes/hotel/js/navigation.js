var forward;
var backward;

$.touch.triggerMouseEvents = false;
$.touch.preventDefault = false;

function setNavigationOrder(f,b){
    forward = f;
    backward = b;
}

$(document).touchable({
    gesture: function (e, touchHistory) {
        var touches = $(this).touches();
        if (touches.length == 1) {
            var th = touchHistory.stop({
                type: ['touchdown', 'touchup']
            }).filter({
                touch: touchHistory.get(0).touch,
                type: 'touchmove',
                time: '1..100'
            });
            //left
            if (th.match({ deltaX: '<-300' })) {
                window.location.replace(backward);
            //right
            } else if (th.match({ deltaX: '>300' })) {
                window.location.replace(forward);
            //down
            } else if (th.match({ deltaY: '>100' })) {
                //window.location.replace(forward);
            //up
            } else if (th.match({ deltaY: '<-100' })) {
                //window.location.replace(backward);
                
            }
        }
    }
});

//function message(s) {
//    $('#message').html(s);
//}