

var venezia = (function(){



    var obj = {
        score: 0,
        isStart: false,
        country:"kr"
    };
    return obj;




}());



requirejs.config({

    baseUrl: "src",
    urlArgs: "bust=" + (new Date()).getTime(),
    paths: {
        common: 'common',
        easeljs: '../lib/easeljs-0.8.0.min',
        soundjs: '../lib/soundjs-0.6.0.min',
        jquery: '../lib/jquery-1.11.2.min',
        TweenMax: '../lib/TweenMax.min',
        text: '../lib/require/text'
    }

});

require([
    'common',
    'easeljs',
    'soundjs',
    'jquery',
    'TweenMax',
    'text'
], function () {

    var $gate = $('.gate');
    var $startBtn = $('.startBtn');

    if(getURLParameter('n') == 'en'){
        venezia.country = 'en';
        $gate.addClass('en');
        $startBtn.addClass('en');
    }

    $gate.show();


    $(document).ready(function(){
        $startBtn.click(function(){
            $gate.hide();
            venezia.isStart = true;
            venezia.UIController.startGame();
        });
    });

    venezia.stageW = 640;
    venezia.stageH = 470;
    venezia.headerH = 22;
    venezia.footerH = 31;
    venezia.textArr = 31;
    venezia.sceneW = 640;
    venezia.sceneH = 470;




    venezia.sprite = {
        "animations": {
            "header": {"frames": [0]},
            "footer": {"frames": [1]},
            "block1": {"frames": [2]},
            "block2": {"frames": [3]},
            "typingArea": {"frames": [4]},
            "step1": {"frames": [5]}
        },
        "images": ["assets/venezia/images/venezia_sprite.png"],
        "frames": [
            [0, 0, 640, 22, 0, 0, 0],
            [0, 22, 640, 31, 0, 0, 0],
            [0, 53, 32, 16, 0, 0, 0],
            [32, 53, 32, 16, 0, 0, 0],
            [0, 69, 112, 48, 0, 0, 0],
            [0, 117, 232, 48, 0, 116, 24]
        ]
    };
    venezia.spriteSheet = new createjs.SpriteSheet(venezia.sprite);






    require([

        'venezia/text/WordController',
        'venezia/ui/UIController',
        'venezia/sound/SoundController',
        'text!../assets/venezia/text/words_'+venezia.country+'.txt'


    ], function (WordController, UIController, SoundController, data) {


        var stage = new createjs.Stage(document.getElementById("gameCanvas"));
        stage.snapToPixelEnabled = true;
        venezia.stage = stage;


        var arr = data.split('\n');

        arr = $.shuffle(arr);




        venezia.textArr = arr;
        venezia.WordController = WordController;
        venezia.UIController = UIController;
        venezia.SoundController = SoundController;

        SoundController.init();

        var startStep1 = function(){
            WordController.init(arr);
        };

        UIController.init(startStep1);




        var update = function(){


            stage.update();
        };


        createjs.Ticker.timingMode = createjs.Ticker.RAF;
        createjs.Ticker.addEventListener("tick", update);

    });









});







