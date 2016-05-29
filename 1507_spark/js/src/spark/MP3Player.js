



define([
    ""
], function () {

    var $sndBtn = $('.sndBtn');
    $sndBtn.mouseenter(function(){
        exports.over();
    });
    $sndBtn.click(function(){
        exports.click();
    });


    var exports = {

        init: function(){

        },

        over: function(){
            window.thisMovie('player1').PlaySound('over');
        },

        click: function(){
            window.thisMovie('player1').PlaySound('click');
        },

        car: function(){
            window.thisMovie('player1').PlaySound('car');
        },

        playMP3: function(n){
            window.thisMovie('player1').playMP3();
        },

        loadMP3: function(n){
            setTimeout(function(){
                window.thisMovie('player1').loadMP3(n);
            }, 100);



        },

        outMP3: function(){
            window.thisMovie('player1').outMP3();
        }

    };


    window.loadMP3 = exports.loadMP3;
    window.outMP3 = exports.outMP3;

    return exports;


});





