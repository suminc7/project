
define([
    ""
], function () {

    var stage, monsterArr, sceneW, stageW, container, gateBg, credit, indexImg;


    return {

        init: function(){
            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            stageW = galaga.stageW;
            sceneW = galaga.sceneW;

            this.createContainer();


        },

        remove: function(){
            stage.removeChild(container);



            var newStage = new createjs.Event("newStage");
            this.dispatchEvent(newStage);
        },

        appendGate: function(){
            $('.gate').hide();
            container.addChild(gateBg);
            container.addChild(credit);

            var enterCount = 0;
            var self = this;


            var gateTimer = setInterval(function(){
                if(enterCount == 0){
                    credit.text = "1";
                    galaga.SoundController.coin();
                }else if(enterCount == 1){
                    self.remove();
                    clearInterval(gateTimer);
                }
                enterCount++;
            }, 1000);


            //$(document).bind('keydown', function(e){
            //    if(e.keyCode == 13 || e.keyCode == 32){
            //        if(enterCount == 0){
            //            credit.text = "1";
            //            galaga.SoundController.coin();
            //        }else if(enterCount == 1){
            //            self.remove();
            //        }
            //        enterCount++;
            //    }
            //
            //    e.preventDefault(); // prevent the default action (scroll / move caret)
            //});
        },

        createContainer: function(){

            var self = this;


            gateBg = new createjs.Bitmap("assets/galaga/images/gate.png");
            gateBg.compositeOperation = "lighter";
            //gateBg.x = galaga.sceneW/2 - 224/2;

            var ss = new createjs.SpriteSheet(galaga.numberSprite);
            credit = new createjs.BitmapText("0", ss);
            credit.letterSpacing = 1;
            credit.x = 70;
            credit.y = galaga.sceneH - 10;


            var logoData = {
                "animations": {
                    "logo1": {"frames": [0], "next":"logo2", "speed":0.1},
                    "logo2": {"frames": [1], "next":"logo1", "speed":0.1}
                },
                "images": ["assets/galaga/images/galaga_text.png"],
                "frames": [
                    [24, 226, 90, 45, 0, 0, 0],
                    [126, 226, 90, 45, 0, 0, 0]
                ]
            };

            //var ss = new createjs.SpriteSheet(logoData);
            //var logo = new createjs.Sprite(ss);
            //logo.gotoAndStop(1);
            //logo.x = 72;
            //logo.y = 64;


            container = new createjs.Container();
            container.y = 0;


            stage.addChild(container);


            //var tween = new TweenMax(container, 4, {
            //    y: 0 ,
            //    ease: Linear.easeNone,
            //    onComplete: function(){
            //        logo.gotoAndPlay("logo1");
            //    }
            //});





        }

    };
});
