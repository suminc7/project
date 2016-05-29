
define([
    "spark/MP3Player",
    "spark/Step2"
], function (MP3Player, Step2) {


    var $popup = $('.popup');
    var $close = $('.popup .popup-inner .close');
    var $step1 = $('.step1');

    $('.step1 .event').click(function(){
        TweenMax.from($popup, 0.4, {autoAlpha:0});
        $popup.show();
    });

    $close.click(function(){
        TweenMax.to($popup, 0.4, {autoAlpha:0, 'display': 'none', clearProps:'all'});

    });

    var exports = {

        Step1ShowText: function(){

            //alert('Step1ShowText');

            //console.log('Step1ShowText');

            var delayTime = 1.5;

            setTimeout(function(){
                MP3Player.loadMP3(2);
            }, 1000);

            if(ie8){

                TweenMax.from('.step1 .text1', 0.6, {width:0, ease:Power1.easeInOut, delay:0.1 + delayTime,  overflow:'hidden'});
                TweenMax.from('.step1 .text2', 0.6, {width:0, ease:Power1.easeInOut, delay:0.2 + delayTime,  overflow:'hidden'});
                TweenMax.from('.step1 .line', 0.6, {width:0, ease:Power1.easeInOut, delay:0.3 + delayTime,  overflow:'hidden'});
                TweenMax.from('.step1 .text3', 0.6, {width:0, ease:Power1.easeInOut, delay:0.4 + delayTime, clearProps:'all',  overflow:'hidden'});

                TweenMax.from('.step1 .btn', 0.3, {width:0, ease:Power1.easeInOut, delay:0.5 + delayTime,  overflow:'hidden'});


                $step1.css('display','block');

            }else{
                TweenMax.from('.step1 .text1', 1, {x:80, autoAlpha:0, ease:Power1.easeOut, delay:0.4 + delayTime, clearProps:'all'});
                TweenMax.from('.step1 .text2', 1, {x:80, autoAlpha:0, ease:Power1.easeOut, delay:0.3 + delayTime, clearProps:'all'});
                TweenMax.from('.step1 .line', 1, {width:0, ease:Power1.easeOut, delay:0.5 + delayTime, clearProps:'all'});
                TweenMax.from('.step1 .text3', 1, {x:80, autoAlpha:0, ease:Power1.easeOut, delay:0.1 + delayTime, clearProps:'all'});

                TweenMax.from('.step1 .btn', 0.6, {autoAlpha:0, x:40, ease:Power1.easeOut, delay:0.6 + delayTime, clearProps:'all'});
                $step1.css('display','block');
            }




        },

        Step2Start: function(){
            MP3Player.outMP3();

            $step1.remove();
            window.thisMovie('player1').Step2Start(false);



            window.Step1ShowText = null;
            window.Step2Start = null;
        }
    };


    //console.log('requirejs1');

    window.Step1ShowText = exports.Step1ShowText;
    window.Step2Start = exports.Step2Start;



    return exports;
});
