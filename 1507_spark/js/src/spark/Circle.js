
define([
    "spark/RunArc",
    "spark/ReVideo",
    'spark/PlayBar',
    'spark/MP3Player'
], function (RunArc, ReVideo, PlayBar, MP3Player) {

    var $circle = $('.circle');
    var $side = $('.side');
    var $step;

    var circleIdx = -1;
    var sideIdx = 0;


    var $leftArrowBtn = $('.left-arrow');
    var $rightArrowBtn = $('.right-arrow');

    $leftArrowBtn.click(function(){

        var $sideBtns = $step.find('.side').eq(circleIdx).find('.side-btns a');
        var $desc = $step.find('.side').find(' .desc ');

        var n = sideIdx-1;
        if(n < 0){
            n = $sideBtns.length - 1;
        }
        sideClick(n, $sideBtns, $desc);
        return false;
    });

    $rightArrowBtn.click(function(){

        var $sideBtns = $step.find('.side').eq(circleIdx).find('.side-btns a');
        var $desc = $step.find('.side').find(' .desc ');

        var n = sideIdx+1;
        if(n > $sideBtns.length - 1){
            n = 0;
        }
        sideClick(n, $sideBtns, $desc);
        return false;
    });

    var sideClick = function(idx, $sideBtns, $desc){

        if(sideIdx == idx)return;
        if(sideIdx > -1){
            $desc.eq(sideIdx).hide();
            $sideBtns.eq(sideIdx).removeClass('active');
        }

        $sideBtns.eq(idx).addClass('active');

        var $obj = $desc.eq(idx).show();


        if(ie8){
            TweenMax.from($obj.find('.text1'), 0.4, {marginLeft:60, autoAlpha:0, ease:Power1.easeOut, delay:0, clearProps:'all'});
            TweenMax.from($obj.find('.text2'), 0.4, {marginLeft:60, autoAlpha:0, ease:Power1.easeOut, delay:0.1, clearProps:'all'});
            TweenMax.from($obj.find('.text3'), 0.4, {marginLeft:60, autoAlpha:0, ease:Power1.easeOut, delay:0.2, clearProps:'all'});
        }else{
            TweenMax.from($obj.find('.text1'), 0.4, {x:60, autoAlpha:0, ease:Power1.easeOut, delay:0, clearProps:'all'});
            TweenMax.from($obj.find('.text2'), 0.4, {x:60, autoAlpha:0, ease:Power1.easeOut, delay:0.1, clearProps:'all'});
            TweenMax.from($obj.find('.text3'), 0.4, {x:60, autoAlpha:0, ease:Power1.easeOut, delay:0.2, clearProps:'all'});
        }


        sideIdx = idx;

        var tn_array = $step.find(' .moving-image ').eq(circleIdx).find('img').map(function() {
            return $(this).attr("src");
        });
        RunArc.run(circleIdx, idx, tn_array[idx]);

        return false;

    }


    $side.each(function(){

        var $self = $(this);
        var $sideBtns = $self.find(' .side-btns a ');
        var $desc = $self.find(' .desc ');



        $sideBtns.eq(sideIdx).addClass('active');

        $sideBtns.click(function(){
            var idx = $(this).parent().index();
            sideClick(idx, $sideBtns, $desc);

        });







        var $close = $(this).find('.close');

        $close.mouseenter(function(){
            if(!ie8)TweenMax.to(this, 0.3, {rotation:90});
        });
        $close.mouseleave(function(){
            if(!ie8)TweenMax.to(this, 0.3, {rotation:0});
        });
        $close.click(function(){
            RunArc.close();
            ReVideo.stop(false);
            PlayBar.play();



            TweenMax.to($leftArrowBtn, 0.6, {x:0, ease:Power2.easeInOut});
            TweenMax.to($rightArrowBtn, 0.6, {x:0, ease:Power2.easeInOut});


            if(ie8){
                if($step.selector == ' .step4 '){
                    $self.hide();
                    if(exports.callback) exports.callback();
                }else{
                    TweenMax.to($self, 1, {right:-640, ease:Power2.easeInOut, clearProps:'all', onComplete:function(){
                        if(exports.callback) exports.callback();
                    }});
                }
            }else{

                if($step.selector == ' .step4 '){
                    TweenMax.to($self, 0.3, {autoAlpha:0, ease:Power2.easeInOut, clearProps:'all', onComplete:function(){
                        if(exports.callback) exports.callback();
                    }});
                }else{
                    TweenMax.to($self, 1, {x:640, ease:Power2.easeInOut, clearProps:'all', onComplete:function(){
                        if(exports.callback) exports.callback();
                    }});
                }


            }

        });

    });



    $circle.each(function(idx){

        var $self = $(this);

        $self.css('display', 'none');

        var wid = 0;


        if($self.find('.cr').attr('id') == 'cr3_1'){
            wid = 320;
        }else{
            wid = 280;
        }

        $self.data('wid', wid);


        $.fn.resetCircle = function(){
            $(this).each(function(){
                TweenMax.to($(this).find('.text'), 0, {autoAlpha:1});
                this.cr.attr({width: $(this).data('wid') });
            });

        };

        $self.mouseenter(function(){
            TweenMax.to($self.find('.text'), 0.3, {autoAlpha:1, delay:0.4});
            if(!ie8)TweenMax.to($self.find('.plus'), 0.3, {rotation:180});
            this.cr.animate({width: $self.data('wid') }, 600, "<>");
        });
        $self.mouseleave(function(){
            var $text = $self.find('.text');
            TweenMax.killDelayedCallsTo($text);
            TweenMax.to($text, 0.15, {autoAlpha:0});
            if(!ie8)TweenMax.to($self.find('.plus'), 0.3, {rotation:0});
            this.cr.animate({width: 66}, 600, "<>");
        });
        $self.click(function(){



            TweenMax.to(this, 0.3, {autoAlpha:0, ease:Power2.easeInOut});
            var idx = $(this).index();


            var $side = $step.find('.side');
            var $currentSide = $side.eq(idx);

            if(ie8){
                if($step.selector == ' .step4 '){
                    TweenMax.from($currentSide, 0, {right:-640, ease:Power2.easeInOut});
                }else{
                    TweenMax.from($currentSide, 1, {right:-640, ease:Power2.easeInOut});
                }

            }else{
                if($step.selector == ' .step4 '){
                    TweenMax.from($currentSide, 1, {autoAlpha:0});
                }else{
                    TweenMax.from($currentSide, 1, {x:640, ease:Power2.easeInOut});
                }

            }
            $currentSide.show();

            circleIdx = idx;


            var tn_array = $step.find(' .moving-image ').eq(idx).find('img').map(function() {
                return $(this).attr("src");
            });

            ReVideo.stop();
            PlayBar.stop(true);
            RunArc.run(circleIdx, 0, tn_array[0]);


            if($currentSide.find('.desc').length > 1){
                var $leftArrowBtn = $step.find('.left-arrow');
                var $rightArrowBtn = $step.find('.right-arrow');
                TweenMax.to($leftArrowBtn, 0.6, {x:62, delay:0.6, ease:Power2.easeInOut});
                TweenMax.to($rightArrowBtn, 0.6, {x:-62, delay:0.6, ease:Power2.easeInOut});



            }

        });

        var id = $self.find('.cr').attr('id');
        Raphael(id, wid, 70, function () {
            $self[0].cr = this.rect(0, 0, wid, 66, 33).attr({stroke: "none", fill: "#000", opacity:0.5});
        });

    });

    var exports = {

        init: function( $s, callback){
            $step = $s;
            this.callback = callback;
            $circle.resetCircle();
            RunArc.init($step);

            sideIdx = 0;
        },


        run: function(n){

        },

        close: function(){



        }
    };
    return exports;


});





