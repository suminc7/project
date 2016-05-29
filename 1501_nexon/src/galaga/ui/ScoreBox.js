define([
    "",
    ""
], function () {

    var stage, monsterArr, sceneW, stageW, container, myscore, oneup;






    return {

        init: function(){
            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            stageW = galaga.stageW;
            sceneW = galaga.sceneW;

            galaga.planeArr = [];

            this.createPlane();

        },

        gateInit: function(s){
            stage = s;
            this.createContainer();
            this.createText();
        },

        //ready 후에 비행기 삭제
        removePlane: function(){
            var plane = container.getChildByName("plane" + galaga.life);
            container.removeChild(plane);
        },

        createStageObject: function(){

            var ss = new createjs.SpriteSheet(galaga.stageSprite);
            var object = new createjs.Sprite(ss, 'stage');
            object.x = galaga.sceneW - 10;
            object.y = galaga.sceneH - 15;
            container.addChild(object);
        },

        createPlane: function(){
            var ss = new createjs.SpriteSheet(galaga.planeSprite);
            var plane1 = new createjs.Sprite(ss, 'plane');
            plane1.name = "plane1";
            plane1.x = 12;
            plane1.y = galaga.sceneH - 12;
            container.addChild(plane1);

            var plane2 = new createjs.Sprite(ss, 'plane');
            plane2.name = "plane2";
            plane2.x = 10+16;
            plane2.y = galaga.sceneH - 12;
            container.addChild(plane2);

            var plane3 = new createjs.Sprite(ss, 'plane');
            plane3.name = "plane3";
            plane3.x = 10+16+16;
            plane3.y = galaga.sceneH - 12;
            container.addChild(plane3);
        },

        createText: function(){
            var ss;

            ss = new createjs.SpriteSheet(galaga.textSprite);

            var high = new createjs.Sprite(ss, 'highscore2');
            high.x = galaga.sceneW/2;
            high.y = 3;
            container.addChild(high);

            ss = new createjs.SpriteSheet(galaga.numberSprite);
            var hscore = new createjs.BitmapText("30000", ss);
            hscore.letterSpacing = 1;
            hscore.x = galaga.sceneW/2;
            hscore.y = 12;
            hscore.regX = 20;
            container.addChild(hscore);


            ss = new createjs.SpriteSheet(galaga.textSprite);
            oneup = new createjs.Sprite(ss, '1up');
            oneup.x = 6;
            oneup.y = 3;
            container.addChild(oneup);

            ss = new createjs.SpriteSheet(galaga.numberSprite);
            myscore = new createjs.BitmapText("00", ss);
            myscore.letterSpacing = 1;
            myscore.x = 15;
            myscore.y = 12;
            container.addChild(myscore);

            //myscore.regX = myscore.text.length*7;


        },

        setScore: function(score){
            galaga.score += score;
            myscore.text = "" + galaga.score;
            //console.log(myscore.regX);
            //myscore.regX = myscore.text.length*7;
        },

        createContainer: function(){

            container = new createjs.Container();
            stage.addChild(container);
            //console.log(stage);
        },

        initStart: function(){

            var count = 0;
            setInterval(function(){
                if(count == 0){
                    oneup.visible = false;
                }else{
                    oneup.visible = true;
                    count = -1;
                }
                count++;
            }, 500);
        }


    };
});
