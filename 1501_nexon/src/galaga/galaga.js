

var galaga = (function(){



    var obj = {
        score: 0,
        life: 3,
        liveMonsters: 0
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
        TweenMax: '../lib/TweenMax.min'
    }

});

require([
    'common',
    'easeljs',
    'soundjs',
    'jquery',
    'TweenMax'
], function () {



    galaga.scoreW = 0;
    galaga.stageW = 238;
    galaga.stageH = 292;

    galaga.monsterArr = [];
    galaga.sceneW = galaga.stageW;
    galaga.sceneH = galaga.stageH;



    require([

        'galaga/plane/PlaneController',
        'galaga/monster/MonsterController',
        'galaga/ui/UIController',
        'galaga/gate/GateController',
        'galaga/sound/SoundController',
        'galaga/graphics/Backgrounds'


    ], function (PlaneController, MonsterController, UIController, GateController, SoundController, Backgrounds) {



        galaga.PlaneController = PlaneController;
        galaga.MonsterController = MonsterController;
        galaga.UIController = UIController;
        galaga.GateController = GateController;
        galaga.SoundController = SoundController;



        var stage = new createjs.Stage(document.getElementById("gameCanvas"));
        stage.snapToPixelEnabled = true;
        galaga.stage = stage;

        Backgrounds.init();


        var update = function(){
            //var bg = new createjs.Shape();
            //if(galaga.plane)bg.graphics.beginFill("#2affe3").drawRect(galaga.monsterArr[7].x, galaga.monsterArr[7].y, 1, 1);
            //stage.addChild(bg);
            stage.update();
        };
        createjs.Ticker.timingMode = createjs.Ticker.RAF;
        createjs.Ticker.addEventListener("tick", update);



        createjs.EventDispatcher.initialize(GateController);
        createjs.EventDispatcher.initialize(PlaneController);
        createjs.EventDispatcher.initialize(UIController);


        SoundController.init();
        GateController.init();
        UIController.gateInit(stage);
        GateController.addEventListener("newStage", function(event) {



            initReady();
            event.remove();
        });


        UIController.addEventListener("readyComplete", function(event) {
            PlaneController.init();
            MonsterController.init();
            event.remove();




        });


        var initReady = function(){
            UIController.init();
        }








    });









});





























