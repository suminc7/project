




define([
    'feature/controller/Wheel'
], function (Wheel) {

    var parents, isShow = true;

    var $intro = $('.intro'), $introUI = $intro.find('.intro-ui'), $detailBtn = $intro.find('.detail-btn'), $wheel = $intro.find('.wheel');



    $detailBtn.click(function(){
        Wheel.movePage(-1);
    });


    var str = '';
    for (var i = 0;i<74;i++){
        var n = i < 10 ? "0"+i : i;
        str += '<img src="'+imgServerDomain+'/images/video/2D/scroll/scroll_000'+n+'.png" class="scroll" alt="">';
    }
    $wheel.append(str);
    var $scroll = $('.scroll');

    var count = 1;

    function timerFunction(){

        if(count > -1) $scroll.eq(count).hide();

        count++;
        if(count > 74){
            count = 0;
        }
        $scroll.eq(count).show();


    }

    var timer = setInterval(timerFunction, 30);


    var video = '<video id="introVideo" width="1920" height="800" loop autoplay muted poster="'+imgServerDomain+'/images/video/2D/main-edit-first.jpg"><source src="'+imgServerDomain+'/images/video/2D/main-edit.mp4" type="video/mp4"></video>';
    if(ie8){
        video = '<img src="'+imgServerDomain+'/images/common/intro.jpg" class="intro1" alt="" onload="introLoaded(this, this.parentElement)">';
    }

    $intro.append(video);
    var introVideo = $('#introVideo')[0];

    if(!ie8){
        TweenMax.set($introUI, {'autoAlpha': 0});
        TweenMax.to($introUI, 1, {'autoAlpha': 1, delay:1});
        TweenMax.set(introVideo, {'visibility': 'hidden'});
    }else{
        TweenMax.set($introUI, {'autoAlpha': 1});
    }

    if(md.tablet()){
        TweenMax.set($introUI, {'autoAlpha': 0});
        TweenMax.to($introUI, 1, {'autoAlpha': 1, delay:1});
    }


    var exports = {



        init: function(p){
            parents = p;
            if(!ie8){
                TweenMax.to(introVideo, 0.3, {'autoAlpha': 1});
            }else{

            }


        },

        show: function(){
            if(!isShow){
                isShow = true;
                TweenMax.set($intro, {'visibility': 'visible'});

                if(!ie8)introVideo.play();

                timer = setInterval(timerFunction, 30);
            }
        },

        pause: function(){
            if(!ie8)introVideo.pause();
        },

        hide: function(){
            if(isShow){

                isShow = false;
                TweenMax.set($intro, {'visibility': 'hidden'});
                if(!ie8)introVideo.pause();
            }

            clearInterval(timer);
        }



    };

    return exports;


});













