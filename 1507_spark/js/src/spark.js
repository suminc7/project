


requirejs.config({

    baseUrl: spark.path + "/js/src",
    urlArgs: "bust=" + (new Date()).getTime(),
    paths: {
        TweenMax: spark.path + '/js/vendor/TweenMax.min',
        raphael: spark.path + '/js/vendor/raphael',
        curvycorners: spark.path + '/js/vendor/curvycorners',
        swfobject: spark.path + '/js/vendor/swfobject',
        RaphaelPlugin: spark.path + '/js/vendor/RaphaelPlugin.min'
    }

});

require([
    'TweenMax',
    'curvycorners',
    'swfobject',
    'RaphaelPlugin'

], function () {




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
    swfobject.embedSWF(spark.path + "/asset/swf/player.swf", "player1", "100%", "100%", "10.0.0" , null, flashvars , params , attributes  );


    var flashvars = {};
    var params = {};
    params.wmode = 'transparent';
    params.menu = 'false';
    params.base = '.';
    var attributes = {};
    flashvars.debug = 0;
    flashvars.path = spark.path;
    attributes.name = "player2";
    attributes.id = "player2";
    swfobject.embedSWF(spark.path + "/asset/swf/playerRe.swf", "player2", "100%", "100%", "10.0.0" , null, flashvars , params , attributes  );

    //$('#player2').hide();



    require([
        'spark/Gnb',
        'spark/PlayBar',
        'spark/Step1'
    ], function () {




    });

});

