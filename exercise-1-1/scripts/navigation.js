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
        if (touches.length >= 2) {
            var th = touchHistory.stop({
                type: ['touchdown', 'touchup']
            }).filter({
                type: 'touchmove',
                time: '1..100'
            });
            if (th.match([{ touch: touches[0], deltaX: '<-100' }, { touch: touches[1], deltaX: '<-100'}])) {
                //message('two swipe left');
            }
            else if (th.match([{ touch: touches[0], deltaX: '>100' }, { touch: touches[1], deltaX: '>100'}])) {
                //message('two swipe right');
            }
            else if (th.match([{ touch: touches[0], deltaY: '>100' }, { touch: touches[1], deltaY: '>100'}])) {
                //message('two swipe down');
            }
            else if (th.match([{ touch: touches[0], deltaY: '<-100' }, { touch: touches[1], deltaY: '<-100'}])) {
                //message('two swipe up');
            }

        } else {
            var th = touchHistory.stop({
                type: ['touchdown', 'touchup']
            }).filter({
                touch: touchHistory.get(0).touch,
                type: 'touchmove',
                time: '1..100'
            });
            if (th.match({ deltaX: '<-100' })) {
                //message('one swipe left');
                window.location.replace(backward);
            } else if (th.match({ deltaX: '>100' })) {
                //message('one swipe right');
                window.location.replace(forward);
            } else if (th.match({ deltaY: '>100' })) {
                //message('one swipe down');
            } else if (th.match({ deltaY: '<-100' })) {
                //message('one swipe up');
            }
        }
    }
});

//function message(s) {
//    $('#message').html(s);
//}