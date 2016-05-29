
define([
    "galaga/ui/ScoreBox"
], function (ScoreBox) {

    var stage, monsterArr, sceneW, stageW, container, monsterContainer;

    galaga.textSprite = {
        "animations": {
            "highscore": {"frames": [0]},
            "1up": {"frames": [1]},
            "start": {"frames": [2]},
            "stage1": {"frames": [3]},
            "ready": {"frames": [4]},
            "result": {"frames": [5]},
            "gameover": {"frames": [6]},
            "highscore2": {"frames": [7]},
            "s1600": {"frames": [8]},
            "s400": {"frames": [9]}
        },
        "images": ["assets/galaga/images/galaga_text.png"],
        "frames": [
            [192, 29, 47, 15, 0, 0, 0],
            [26, 29, 22, 7, 0, 0, 0],
            [26, 66, 39, 7, 0, 20, 0],
            [26, 100, 71, 7, 0, 35, 0],
            [84, 66, 39, 7, 0, 20, 0],
            [0, 294, 184, 80, 0, 0, 0],
            [142, 66, 71, 7, 0, 35, 0],
            [107, 29, 63, 7, 0, 31, 0],
            [24, 204, 16, 7, 0, 8, 0],
            [45, 204, 15, 7, 0, 7, 0]
        ]
    };

    galaga.numberSprite = {
        "animations": {
            "0": {"frames": [0]},
            "1": {"frames": [1]},
            "2": {"frames": [2]},
            "3": {"frames": [3]},
            "4": {"frames": [4]},
            "5": {"frames": [5]},
            "6": {"frames": [6]},
            "7": {"frames": [7]},
            "8": {"frames": [8]},
            "9": {"frames": [9]}
        },
        "images": ["assets/galaga/images/galaga_text.png"],
        "frames": [
            [25, 184, 7, 7, 0, 0, 0],
            [37, 184, 6, 7, 0, 0, 0],
            [48, 184, 7, 7, 0, 0, 0],
            [60, 184, 7, 7, 0, 0, 0],
            [72, 184, 7, 7, 0, 0, 0],
            [84, 184, 7, 7, 0, 0, 0],
            [96, 184, 7, 7, 0, 0, 0],
            [108, 184, 7, 7, 0, 0, 0],
            [120, 184, 7, 7, 0, 0, 0],
            [132, 184, 7, 7, 0, 0, 0]
        ]
    };


    galaga.planeSprite = {
        "animations": {
            "plane": {"frames": [0]}
        },
        "images": ["assets/galaga/images/plane.png"],
        "frames": [
            [0, 0, 17, 18, 0, 8, 9]
        ]
    };
    galaga.stageSprite = {
        "animations": {
            "stage": {"frames": [0]}
        },
        "images": ["assets/galaga/images/NES-Galaga-Galaga.png"],
        "frames": [
            [360, 282, 7, 12, 0, 0, 0]
        ]
    };


    return {

        init: function(){
            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            stageW = galaga.stageW;
            sceneW = galaga.sceneW;

            container = new createjs.Container();
            container.name = "uiContainer";
            stage.addChild(container);



            this.createObject();
            ScoreBox.init();

        },

        gateInit: function(stage){
            ScoreBox.gateInit(stage);
        },

        reReady: function(){
            var self = this;
            galaga.life--;

            setTimeout(function(){
                if(galaga.life > 0){
                    self.initReady();
                }else{
                    self.result();



                }
            }, 3000);

        },

        // 다 죽고난 후 결과 창
        result: function(){
            var ss = new createjs.SpriteSheet(galaga.textSprite);
            var gameover = new createjs.Sprite(ss, 'gameover');
            gameover.compositeOperation = "lighter";
            gameover.x = sceneW/2;
            gameover.y = galaga.sceneH/2;
            container.addChild(gameover);


            setTimeout(function(){

                monsterContainer = stage.getChildByName("monsterContainer");
                stage.removeChild(monsterContainer);


                container.removeChild(gameover);


                gameFinished(galaga.score);

                //var result = new createjs.Sprite(ss, 'result');
                //result.compositeOperation = "lighter";
                //result.x = galaga.sceneW/2 - 184/2;
                //result.y = galaga.sceneH/2 - 80/2;
                //container.addChild(result);
                //
                //
                //setTimeout(function(){
                //    if(parent.window.gameFinish) parent.window.gameFinish(galaga.score);
                //}, 2000);

            }, 3000);

        },

        setScore: function(score){
            ScoreBox.setScore(score);
        },

        createObject: function(){

            var ss = new createjs.SpriteSheet(galaga.textSprite);
            var self = this;
            var start, stage1, ready;



            var initStart = function(){

                galaga.SoundController.gameStart();

                start = new createjs.Sprite(ss, 'start');
                start.x = sceneW/2;
                start.y = galaga.sceneH/2;
                container.addChild(start);

                ScoreBox.initStart();

                setTimeout(function(){
                    initStage1();
                }, 3000);

            };

            var initStage1 = function(){
                container.removeChild(start);

                setTimeout(function(){
                    stage1 = new createjs.Sprite(ss, 'stage1');
                    stage1.x = sceneW/2;
                    stage1.y = galaga.sceneH/2;
                    container.addChild(stage1);

                    ScoreBox.createStageObject();
                }, 300);

                setTimeout(function(){
                    self.initReady();
                }, 3000);
            };

            self.initReady = function(){
                container.removeChild(stage1);
                ready = new createjs.Sprite(ss, 'ready');
                ready.x = sceneW/2;
                ready.y = galaga.sceneH/2;
                container.addChild(ready);


                setTimeout(function(){
                    removeReady();
                }, 3000);
            };

            var isReadyEvent = false;
            var removeReady = function(){
                container.removeChild(ready);

                ScoreBox.removePlane();


                if(isReadyEvent){
                    galaga.PlaneController.createPlane();
                }else{
                    var readyComplete = new createjs.Event("readyComplete");
                    self.dispatchEvent(readyComplete);
                }
                isReadyEvent = true;



            };

            initStart();







        }



    };
});
