
define([
    "spark/MP3Player",
    "spark/Step5",
    "spark/Circle",
    "spark/PlayBar"
], function (MP3Player, Step5, Circle, PlayBar) {
    var $step4 = $(' .step4 ');
    var $startDesc = $('.step4 .start-desc');
    var $leftBtn = $('.step4 .left-btn');
    var $rightBtn = $('.step4 .right-btn');

    var exports = {

        Step4Show: function(){
            //console.log('Step4Show');
            MP3Player.loadMP3(4);
            $step4.show();

            if(ie8){

            }else{
                TweenMax.from($leftBtn, 1, {autoAlpha:0});
                TweenMax.from($rightBtn, 1, {autoAlpha:0});
                TweenMax.from($startDesc, 1, {autoAlpha:0});
                $startDesc.find('img').each(function(idx){
                    TweenMax.from(this, 0.8, {autoAlpha:0, y:20, delay:idx*0.15});
                });

            }

            $rightBtn.show();
            $leftBtn.show();
            $startDesc.show();

        },

        Step4OnButton: function(){
            $rightBtn.hide();
            $leftBtn.hide();
            $startDesc.hide();

            Circle.init($step4);
            TweenMax.from('.step4 .circle', 0.3, {autoAlpha:0, clearProps:'all'});
            TweenMax.delayedCall(3, function(){ $('.step4 .circle').trigger('mouseleave'); });
            $step4.show();
        },

        Step4OffButton: function(){
            TweenMax.to('.step4 .circle', 0.3, {autoAlpha:0});

        },

        Step4Hide: function(){
            MP3Player.outMP3();
            $step4.css('display','none');
            PlayBar.reset();
        },

        Step5Start: function(n){
            $('.spot3').find('.checked').css('display','block');
            window.thisMovie('player1').Step5Start(false, n);
        }
    };


    window.Step4OnButton = exports.Step4OnButton;
    window.Step4OffButton = exports.Step4OffButton;
    window.Step4Show = exports.Step4Show;
    window.Step4Hide = exports.Step4Hide;
    window.Step5Start = exports.Step5Start;

    return exports;
});
