



define([
    'spark/PlayBar'
], function (PlayBar) {



    var timer;

    var exports = {

        init: function(){

        },


        play: function(n){

            timer = setTimeout(function(){
                $('#player2').css('top',0);
                setTimeout(function(){

                    PlayBar.stop(true);

                    window.thisMovie('player2').loadReVideo(n);
                }, 500);
            }, 11000);



        },

        stop: function(){
            clearTimeout(timer);
        },

        ReVideoIn: function(){
            //console.log('ReVideoIn');
        },

        ReVideoInComplete: function(){
            //console.log('ReVideoInComplete');
        },

        ReVideoOut: function(){
            //console.log('ReVideoOut');
        },

        ReVideoOutComplete: function(){
            //console.log('ReVideoOutComplete');
            $('#player2').css('top',720);
            PlayBar.play(false);
        }
    };


    window.ReVideoIn = exports.ReVideoIn;
    window.ReVideoInComplete = exports.ReVideoInComplete;
    window.ReVideoOut = exports.ReVideoOut;
    window.ReVideoOutComplete = exports.ReVideoOutComplete;

    return exports;


});





