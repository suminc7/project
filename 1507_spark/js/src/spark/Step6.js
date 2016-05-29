
define([
    "spark/Circle"
], function (Circle) {

    var $step6 = $('.step6');

    var exports = {

        Step6Show: function(){
            //console.log('Step6Show');

            if(ie8){

            }else{

            }


            $step6.show();
        },

        Step6OnButton: function(){
            Circle.init($step6);
            TweenMax.from('.step6 .circle', 0.3, {autoAlpha:0, clearProps:'all'});
            TweenMax.delayedCall(3, function(){ $('.step6 .circle').trigger('mouseleave'); });
            $step6.show();
        },

        Step6OffButton: function(){
            TweenMax.to('.step6 .circle', 0.3, {autoAlpha:0});

        },

        Step6Hide: function(){
            $step6.css('display','none');

        },

        Step6End: function(){
            window.location = "index-ending.gm";
        }
    };


    window.Step6OnButton = exports.Step6OnButton;
    window.Step6OffButton = exports.Step6OffButton;

    window.Step6Show = exports.Step6Show;
    window.Step6End = exports.Step6End;
    window.Step6Hide = exports.Step6Hide;

    return exports;
});
