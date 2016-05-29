

requirejs.config({

    baseUrl: spark.path + "/js/src",
    urlArgs: "bust=" + (new Date()).getTime(),
    paths: {
        TweenMax: spark.path + '/js/vendor/TweenMax.min',
        swfobject: spark.path + '/js/vendor/swfobject'
    }

});

require([
    'TweenMax',
    'swfobject'
], function (TweenMax) {

    window.videoStart = function(){
        if(ie8){

        }else{
            TweenMax.from('.type1 .t1', 1, {autoAlpha:0, y:60, delay:0.3, clearProps:'all', ease:Power1.easeInOut});
            TweenMax.from('.type1 .t2', 1, {autoAlpha:0, y:60, delay:0.5, clearProps:'all', ease:Power1.easeInOut});
            TweenMax.from('.text-wrap', 1, {autoAlpha:0});
        }


        $('.text-wrap').show();


    };

    window.videoEnd = function(){
        if(ie8){

            $('.type1').hide();
            $('.type2').show();
        }else{


            TweenMax.to('.type1 .t1', 0.8, {autoAlpha:0, x:-20, delay:0.1, ease:Power1.easeInOut});
            TweenMax.to('.type1 .t2', 0.8, {autoAlpha:0, x:20, delay:0.2, ease:Power1.easeInOut, onComplete:function(){
                $('.type1').hide();


                TweenMax.from('.type2 .t1', 0.8, {autoAlpha:0, x:20, delay:0.0, clearProps:'all'});
                TweenMax.from('.type2 .t2', 0.8, {autoAlpha:0, x:-20, delay:0.1, clearProps:'all'});
                TweenMax.from('.type2 .event-btn', 0.8, {autoAlpha:0, y:20, delay:0.4, clearProps:'all'});
                TweenMax.from('.type2 .btn1', 0.8, {autoAlpha:0, y:20, delay:0.8, clearProps:'all'});
                TweenMax.from('.type2 .btn2', 0.8, {autoAlpha:0, y:20, delay:0.8, clearProps:'all'});
                TweenMax.from('.type2 .line', 0.8, {width:0, delay:0.8, clearProps:'all'});
                $('.type2').show();
            }});


        }




    };





    var flashvars = {};
    var params = {};
    params.wmode = 'opaque';
    params.menu = 'false';
    params.base = '.';
    var attributes = {};
    flashvars.debug = 0;
    flashvars.path = spark.path;
    attributes.name = "player1";
    attributes.id = "player1";
    swfobject.embedSWF(spark.path + "/asset/swf/end.swf", "player1", "100%", "100%", "10.0.0" , null, flashvars , params , attributes  );

    require([
        'spark/Gnb'
    ], function () {


    });



});


