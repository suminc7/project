
define([
    ""
], function () {

    var $playbar = $(' #playbar');
    var $playBtn = $('#playbar .play-btn');
    var $sndBtn = $('#playbar .snd-btn');
    var $spot = $('#playbar .spot');
    var $timer = $('#playbar .timer');
    var $seek = $('#playbar .seek');
    var $spot1 = $('#playbar .spot1');
    var $spot2 = $('#playbar .spot2');
    var $spot3 = $('#playbar .spot3');
    var $spot4 = $('#playbar .spot4');

    var isCircle = false;


    window.playVideo = function(){

    };


    $playBtn.bind('click', function(){
        if(isCircle) return;

        if($(this).hasClass('on')){
            exports.stop(false);
        }else{
            exports.play(false);
        }

    });
    $sndBtn.bind('click', function(){

        if($(this).hasClass('on')){
            $(this).removeClass('on');
            window.thisMovie('player1').offSoundAll();
        }else{
            $(this).addClass('on');
            window.thisMovie('player1').onSoundAll();
        }

    });
    if(ie8){

    }else{
        $spot.each(function(){
            var $self = $(this);
            $self.append('<div class="arc"><div class="arc1"></div><div class="arc2"></div></div>');
        });
    }


    TweenMax.set($spot.find('.arc1'), {scaleX:0, scaleY:0});
    TweenMax.set($spot.find('.arc2'), {scaleX:0, scaleY:0});

    $spot.bind('mouseenter', function(){
        var $self = $(this);
        $self.addClass('on');
        var $img = $self.find('.spot-img');
        var $arc1 = $self.find('.arc1');
        var $arc2 = $self.find('.arc2');

        if(ie8){

        }else{
            TweenMax.from($img, 0.3, {autoAlpha:0, y:-5, clearProps:'all'});
            TweenMax.to($arc1, 0.3, {scaleX:1.5, scaleY:1.5, ease:Back.easeOut});//front
            TweenMax.to($arc2, 0.3, {scaleX:1.3, scaleY:1.3, ease:Back.easeOut});//back
        }

    });
    $spot.bind('mouseleave', function(){
        var $self = $(this);
        var $img = $self.find('.spot-img');
        var $arc1 = $self.find('.arc1');
        var $arc2 = $self.find('.arc2');

        if(ie8){
            $self.removeClass('on');
        }else{
            TweenMax.to($img, 0.3, {autoAlpha:0, y:-5, clearProps:'all', onComplete:function(){
                $self.removeClass('on');
            }});
            TweenMax.to($arc1, 0.2, {scaleX:0, scaleY:0});
            TweenMax.to($arc2, 0.2, {scaleX:0, scaleY:0});
        }

    });

    $spot.bind('click', function(){
        if(isCircle)return;
        var idx = $(this).index();
        window.thisMovie('player1').Spot(idx);
    });



    var exports = {

        play: function(boolean){
            isCircle = boolean;
            $playBtn.addClass('on');
            window.thisMovie('player1').PlayVideo();
        },

        reset: function(){
            isCircle = false;
            $playBtn.addClass('on');
        },

        stop: function(boolean){
            isCircle = boolean;
            $playBtn.removeClass('on');
            window.thisMovie('player1').StopVideo();
        },

        setPlayBar: function(n, time){
            //console.log(time);
            if(n <= 1){
                $seek.width((n * 100)+"%");
                //console.log(n);

                var secondTime = time;
                var minuteTime = 0;
                //var totalTime = 100.14;

                while (secondTime > 60) {
                    minuteTime++;
                    secondTime -= 60;
                }
                secondTime = secondTime < 10 ? "0" + secondTime : secondTime;

                $timer.html(minuteTime + ":" + secondTime);
            }

        },
        setSpot: function(s2, s3, s4, s5, s6){
            $spot1.css('left',s2*100+"%");
            $spot2.css('left',(s2+s3)*100+"%");
            $spot3.css('left',(s2+s3+s4)*100+"%");
            $spot4.css('left',(s2+s3+s4+s5)*100+"%");
        },

        showPlayBar: function(){
            if(ie8){

            }else{
                TweenMax.from($playbar, 0.6, {y:65, ease:Power1.easeInOut});
            }
            $playbar.show();
        },

        hidePlayBar: function(){
            $playbar.hide();
        }
    };


    window.setPlayBar = exports.setPlayBar;
    window.showPlayBar = exports.showPlayBar;
    window.hidePlayBar = exports.hidePlayBar;
    window.setSpot = exports.setSpot;

    return exports;
});
