
define([
    "spark/MP3Player",
    "spark/Step3",
    "spark/Circle",
    "spark/ReVideo",
    "spark/PlayBar"
], function (MP3Player, Step3, Circle, ReVideo, PlayBar) {

    var $start = $('.step2 .start');
    var $startDesc = $('.step2 .start-desc');
    var startCount = 0;
    var b, c, d, clickImg;

    var closeCallback = function(){
        startCount++;

        if(startCount > 1){

        }
    };






    var $step2 = $('.step2');
    var raphaelCheck = false;


    var $startBtn = $('.step2 .start');
    $startBtn.mousedown(function(){
        $startBtn.unbind('mouseleave');

        b.animate({"r": 80}, 100, ">");
        c.animate({"r": 45}, 100, ">");

        //MP3Player.car();
    });
    $startBtn.mouseup(function(){
        b.animate({"r": 94}, 400, "backOut");
        c.animate({"r": 94}, 400, "backOut", function(){
            exports.Step3Start();
        });
    });
    $startBtn.mouseenter(function(){
        b.animate({"r": 84}, 400, "backOut");
        c.animate({"r": 47}, 400, "backOut");
    });
    $startBtn.mouseleave(function(){
        b.animate({"r": 94}, 400, "backOut");
        c.animate({"r": 52}, 400, "backOut");
    });




    var exports = {

        Step2Show: function(){
            //console.log('Step2Show');
            MP3Player.loadMP3(2);
            ReVideo.play(0);
            $step2.css('display','block');
            Circle.init($step2, closeCallback);


            if(ie8){
                TweenMax.set('.step2 .circle1', {autoAlpha:1});
                TweenMax.set('.step2 .circle2', {autoAlpha:1});
                $step2.find('.circle1').show();
                $step2.find('.circle2').show();
            }else{


                TweenMax.from('.step2 .circle1', 0.3, {autoAlpha:0, clearProps:'all'});
                TweenMax.from('.step2 .circle2', 0.3, {autoAlpha:0, clearProps:'all'});

                TweenMax.delayedCall(3, function(){ $('.step2 .circle1').trigger('mouseleave'); });
                TweenMax.delayedCall(3.5, function(){ $('.step2 .circle2').trigger('mouseleave'); });

            }

            if(raphaelCheck){
                b.attr({"r": 5});
                c.attr({"r": 5});
                d.attr({"r": 5});
                //clickImg.attr({"opacity": 0});

            }else{
                Raphael("step2Click", 200, 200, function () {
                    b = this.circle(100, 100, 5).attr({fill: "#FFF",stroke: "none", 'opacity':0.3});
                    c = this.circle(100, 100, 5).attr({fill: "#000",stroke: "none", 'opacity':0.5});
                    d = this.circle(100, 100, 5).attr({fill: "#FFF",stroke: "none", 'opacity':1});
                    //clickImg = this.image("images/step2/start_text.png", 100-24, 100-6, 47, 13).attr({'opacity':0});
                });
            }
            raphaelCheck = true;


            if(ie8){

            }else{
                TweenMax.from($start, 0.6, {autoAlpha:0, delay:0.3});
                TweenMax.from($startDesc, 1, {autoAlpha:0});
                $startDesc.find('img').each(function(idx){
                    TweenMax.from(this, 0.8, {autoAlpha:0, y:20, delay:idx*0.15, clearProps:'all'});
                });

            }

            TweenMax.to(d, 0.6, {raphael:{r:34}, delay:0.3, ease:Back.easeOut});
            TweenMax.to(c, 0.6, {raphael:{r:52}, delay:0.2, ease:Back.easeOut});
            TweenMax.to(b, 0.6, {raphael:{r:94}, delay:0.1, ease:Back.easeOut});
            //TweenMax.to(clickImg, 0.6, {raphael:{opacity:1}, delay:0.3});

            var tween1 = function(){
                TweenMax.to(d, 0.6, {raphael:{fill:"#f4bc00"}, onComplete:tween2});
            };
            var tween2 = function(){
                TweenMax.to(d, 0.6, {raphael:{fill:"#FFF"}, onComplete:tween1});
            };
            tween1();


            $start.show();
            $startDesc.show();



        },

        Step2ReOn: function(){
            $step2.hide();
        },

        Step2ReOff: function(){
            $step2.show();
        },

        Step2Hide: function(){
            MP3Player.outMP3();
            $step2.css('display','none');
            ReVideo.stop();
            PlayBar.reset();
            TweenMax.killTweensOf(d);
        },

        Step3Start: function(){
            $('.spot1').find('.checked').css('display','block');
            window.thisMovie('player1').Step3Start(false);
        }


    };


    //exports.Step2Show();

    window.Step2Show = exports.Step2Show;
    window.Step2ReOn = exports.Step2ReOn;
    window.Step2ReOff = exports.Step2ReOff;
    window.Step2Hide = exports.Step2Hide;
    window.Step3Start = exports.Step3Start;

    return exports;
});
