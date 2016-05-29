define([
    ''
], function () {

    var $stepVideo = $('#stepVideo');
    var stepVideo = $stepVideo[0];
    TweenMax.set($stepVideo, {'autoAlpha': 0});

    //if($.browser.win){
    //    if($.browser.msie || $.browser.chrome){
    //        $stepVideo.addClass('brightness');
    //    }
    //}

    window.stepVideoLoaded = function(video){

        video.play();


        ////$stepVideo.show();
        //TweenMax.to($stepVideo, 0.3, {'autoAlpha': 1, onComplete:function(){
        //
        //
        //}});

        //setTimeout(function(){
        //    $stepVideo.show();
        //}, 200);
        //
        var timer = setInterval(function(){

            if(stepVideo.currentTime > 0.1){
                //$stepVideo.show();
                //$(video).parent().addClass('ie8');
                clearInterval(timer);
                TweenMax.killTweensOf($stepVideo);
                TweenMax.to($stepVideo, 0.1, {'autoAlpha': 1, onComplete:function(){

                    $(video).parent().addClass('ie8');
                }});


            }

            //TweenMax.to($stepVideo, 0.3, {'autoAlpha': 1, onComplete:function(){
            //
            //
            //}});

        }, 50);
    };


    var exports = function(){

        this.enabled = false;
        this.video = null;

        this.step = -1;
        this.obj = '';
        this.url = '';
        this.timer = 0;
        this.delay = 0;

    };

    exports.prototype = {





        init: function(){

        },

        play: function(step) {



            var self = this;
            if(!self.enabled){
                self.enabled = true;

                TweenMax.killTweensOf($stepVideo);





                TweenMax.delayedCall(0.1, function(){
                    $stepVideo.attr({'width':self.width, 'height':self.height, 'poster':self.poster});
                    $stepVideo.find('source').attr('src', self.source);
                    self.obj.prepend($stepVideo);
                    stepVideo.load();
                });


            }

        },

        hide: function(step){
            var self = this;


            if(step == self.step){
                //$stepVideo.attr({'poster':self.poster});
                //$stepVideo.attr({'width':self.width, 'height':self.height, 'poster':self.poster});
            }


            if(self.enabled){


                self.enabled = false;
                console.log('hide :'+this.step);
                stepVideo.pause();
                TweenMax.killTweensOf($stepVideo);
                TweenMax.to($stepVideo, 0.3, {'autoAlpha': 0, onComplete:function(){
                    //$stepVideo.hide();
                    $stepVideo.remove();
                    //TweenMax.set($stepVideo, {'autoAlpha': 1});




                }});
            }else{
                if(this.obj.hasClass('ie8') ){
                    if(this.obj.hasClass('im')){

                    }else{
                        this.obj.removeClass('ie8');
                    }


                }
            }

        },

        start: function(step){
            this.hide(step);


        },

        end: function(step){
            if(step == this.step){
                this.play(step);
            }else{

                this.hide(step);
            }
        }
    };



    return exports;


});













