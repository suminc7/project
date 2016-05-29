
define([
    ""
], function () {

    var stage, monsterArr, sceneW, stageW, stageH;

    var container1, container2, container3, objArr;

    return {

        init: function(){
            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            stageW = galaga.stageW;
            sceneW = galaga.sceneW;
            stageH = galaga.stageH;



            objArr = [];

            this.createContainer();
            this.createBack();
            this.createObject();


            createjs.Ticker.addEventListener("tick", this.update);
        },

        update: function(){
            var len = objArr.length;
            for(var i=0;i<len;i++){
                var obj = objArr[i];
                obj.y += obj.oy;
                obj.ot += 1;
                obj.visible = (Math.abs(obj.ot) % 30) < 15;
                if(obj.y > stageH){
                    obj.y = -stageH;
                }
            }
        },

        createContainer: function(){
            container1 = new createjs.Container();

        },

        createBack: function(){
            var bg = new createjs.Shape();
            bg.graphics.beginFill("#000").drawRect(0, 0, galaga.stageW, galaga.stageH);
            stage.addChild(bg);
        },

        createDot: function(graphics){
            var i;
            for (i = 0;i<40;i++){
                graphics.drawRect(Math.random()*galaga.sceneW, galaga.sceneH - Math.random() * galaga.sceneH * 2, 1, 1);
            }
        },

        createObject: function(){
            var bg;

            //red
            bg = new createjs.Shape();
            bg.graphics.beginFill("#bc1900");
            this.createDot(bg.graphics);
            bg.x = 43; bg.y = bg.ay = 103; bg.oy = 0.5; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);


            bg = new createjs.Shape();
            bg.graphics.beginFill("#bc1900");
            this.createDot(bg.graphics);
            bg.x = 90; bg.y = bg.ay = 209; bg.oy = 0.5; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);

            bg = new createjs.Shape();
            bg.graphics.beginFill("#bc1900");
            this.createDot(bg.graphics);
            bg.x = 90; bg.y = bg.ay = 309; bg.oy = 0.5; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);


            //yellow
            bg = new createjs.Shape();
            bg.graphics.beginFill("#ffff00");
            this.createDot(bg.graphics);
            bg.x = 0; bg.y = bg.ay = -100; bg.oy = 0.90; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);



            bg = new createjs.Shape();
            bg.graphics.beginFill("#ffff00");
            this.createDot(bg.graphics);
            bg.x = 0; bg.y = bg.ay = -200; bg.oy = 0.90; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);

            bg = new createjs.Shape();
            bg.graphics.beginFill("#ffff00");
            this.createDot(bg.graphics);
            bg.x = 0; bg.y = bg.ay = -300; bg.oy = 0.90; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);



            //green
            bg = new createjs.Shape();
            bg.graphics.beginFill("#00ab00");
            this.createDot(bg.graphics);
            bg.x = 0; bg.y = bg.ay = 100; bg.oy = 0.700; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);

            bg = new createjs.Shape();
            bg.graphics.beginFill("#00ab00");
            this.createDot(bg.graphics);
            bg.x = 0; bg.y = bg.ay = 200; bg.oy = 0.700; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);
            stage.addChild(container1);

            bg = new createjs.Shape();
            bg.graphics.beginFill("#00ab00");
            this.createDot(bg.graphics);
            bg.x = 0; bg.y = bg.ay = 0; bg.oy = 0.700; bg.ot = Math.random()*30;
            container1.addChild(bg);
            objArr.push(bg);
            stage.addChild(container1);
        }

    };
});
