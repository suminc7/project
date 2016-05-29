


define([
    "galaga/monster/MonsterMissile"
], function () {

    var stage, sceneW, monsterContainer;

    var bossArr = [0,1,2,3];
    var red1Arr = [4,5,6,7,8,9,10,11];
    var red2Arr = [19,18,17,16,15,14,13,12];
    var blue1Arr = [20,21,22,23,24,25,26,27,28,29];
    var blue2Arr = [39,38,37,36,35,34,33,32,31,30];


    return {

        init: function () {

            stage = galaga.stage;
            sceneW = galaga.sceneW;
            monsterContainer = stage.getChildByName("monsterContainer");

            this.startAnimation();
        },

        startAnimation: function(){
            var self = this;


            var interval = function(arr, axis, func){

                //console.log(galaga.plane);
                if(!galaga.plane){
                    return;
                }

                var monsterArr = galaga.monsterArr;
                for(var i = 0;i<arr.length;i++){
                    var monster = monsterArr[arr[i]];
                    if(monster) {
                        // arr/2 보다 작으면 "L"
                        i = axis == "R" ? i + arr.length/2 : i;
                        axis = (i+1) > arr.length/2 ? "R" : "L";
                        func(monster.num, axis, self);
                        break;
                    }
                }

            };


            setTimeout(function(){
                var func = function(){ interval(blue1Arr, "L", self.monsterAttackBlue); };
                setInterval(func, 12000);
                func();
            }, 13000);

            setTimeout(function(){
                setInterval(function(){
                    interval(blue2Arr, "R", self.monsterAttackBlue);
                }, 12000);
                interval(blue2Arr, "R", self.monsterAttackBlue);
            }, 15000);

            setTimeout(function(){
                setInterval(function(){
                    interval(red1Arr, "L", self.monsterAttackRed);
                }, 13000);
                interval(red1Arr, "L", self.monsterAttackRed);
            }, 17000);

            setTimeout(function(){
                setInterval(function(){
                    interval(red2Arr, "R", self.monsterAttackRed);
                }, 13000);
                interval(red2Arr, "R", self.monsterAttackRed);
            }, 19000);

            setTimeout(function(){
                var count = 0;
                setInterval(function(){
                    if(count == 0){
                        self.monsterAttackBoss([0, 5, 6], self);
                    }else if(count == 1){
                        self.monsterAttackBoss([3, 9, 10], self);
                    }else if(count == 2){
                        self.monsterAttackBoss([1, 6, 7], self);
                    }else if(count == 3){
                        self.monsterAttackBoss([2, 8, 9], self);
                        count = -1;
                    }
                    count++;

                }, 8000);
                self.monsterAttackBoss([2, 8, 9], self);


            }, 21000);



        },



        shootingMissile: function(monster, time){
            if(monster){

                var num = monster.num;
                var time = 1000 - Math.random() * 1000;
                setTimeout(function(){
                    //console.log(num);
                    var monster = galaga.monsterArr[num];
                    if(monster && galaga.plane){
                        var missile = new createjs.MonsterMissile();
                        missile.x = monster.x;
                        missile.y = monster.y + 15;
                        monsterContainer.addChild(missile);
                        missile.shooting();
                    }
                }, time);
            }
        },

        monsterAttackBlue: function(num, axis, self){
            //console.log(galaga.plane);
            if(!galaga.plane){
                return;
            }

            var ax = 1;
            if(axis == "R"){
                ax = -1;
            }
            var monster = galaga.monsterArr[num];
            if(!monster){
                return;
            }

            galaga.SoundController.enemy();

            self.shootingMissile(monster, 1500);

            var mx = monster.mx;
            var my = monster.my;
            var bezTween = new TweenMax(monster, 4.5, {
                bezier: {
                    type: "thru",
                    values: [
                        { x: mx, y: my },
                        { x: mx - 10 * ax, y: my - 10 },
                        { x: mx - 20 * ax, y: my },
                        { x: mx - 10 * ax , y: my + 20 },
                        { x: mx + 10 * ax , y: my + 30 },
                        { x: mx + 40 * ax , y: my + 40 },
                        { x: mx + 70 * ax , y: my + 60 },
                        { x: mx + 80 * ax , y: my + 90 },
                        { x: mx + 90 * ax , y: my + 110 },
                        { x: mx + 80 * ax , y: my + 140 },
                        { x: mx + 60 * ax , y: my + 160 },
                        { x: mx + 40 * ax , y: my + 140 },
                        { x: mx + 30 * ax , y: my + 100 },
                        { x: mx + 20 * ax , y: my + 70 },
                        { x: mx + 20 * ax , y: my + 70 },
                        { x: mx + 10 * ax , y: my + 50 },
                        { x: mx, y: my + 20 },
                        { x: mx, y: my}
                    ],
                    autoRotate: ["x","y","mrotate",90,false]
                },
                ease: Linear.easeNone
            });


            var tween = new TweenMax(monster, 0.1, {mrotate: 0,repeat: 0});

            var tl = new TimelineMax();
            tl.add(bezTween);
            tl.add(tween);
        },


        monsterAttackRed: function(num, axis, self){

            //console.log(galaga.plane);
            if(!galaga.plane){
                return;
            }

            var monster = galaga.monsterArr[num];
            if(!monster){
                return;
            }

            var ax = 1;
            if(axis == "R"){
                ax = -1;
            }

            galaga.SoundController.enemy();

            self.shootingMissile(monster, 1500);

            var mx = monster.mx;
            var my = monster.my;
            var bezTween = new TweenMax(monster, 4.5, {
                bezier: {
                    type: "thru",
                    values: [
                        { x: mx, y: my },
                        { x: mx - 10 * ax, y: my - 10 },
                        { x: mx - 20 * ax, y: my },
                        { x: mx, y: my + 20 },
                        { x: mx + 40 * ax, y: my + 40 },
                        { x: mx + 60 * ax, y: my + 50 },
                        { x: mx + 70 * ax, y: my + 70 },
                        { x: mx + 60 * ax, y: my + 90 },
                        { x: mx + 70 * ax, y: my + 110 },
                        { x: mx + 90 * ax, y: my + 120 },
                        { x: mx + 90 * ax, y: my + 140 },
                        { x: mx + 80 * ax, y: galaga.sceneH+20 }

                    ],
                    autoRotate: ["x","y","mrotate",90,false]
                },
                ease: Linear.easeNone,
                onComplete: function(){
                    monster.x = mx;
                    monster.y = my - 50;
                    var tween1 = new TweenMax(monster, 1.0, {
                        x: mx,
                        y: my,
                        ease: Linear.easeNone
                    });

                    var tween2 = new TweenMax(monster, 0.1, {
                        mrotate: 0,
                        ease: Linear.easeNone
                    });

                    var tl = new TimelineMax();
                    tl.add(tween1);
                    tl.add(tween2);
                }
            });
        },


        monsterAttackBoss: function(arr, self){

            //console.log(galaga.plane);
            if(!galaga.plane){
                return;
            }

            var len = arr.length;
            for (var i = 0;i<len;i++){

                var monster = galaga.monsterArr[arr[i]];

                if(monster){

                    if(i == 0) {
                        self.shootingMissile(monster, 2000);
                        galaga.SoundController.enemy();
                    }

                    var mx = monster.mx;
                    var my = monster.my;
                    var bezTween = new TweenMax(monster, 6.5, {
                        bezier: {
                            type: "thru",
                            values: [
                                { x: mx, y: my },
                                { x: mx + 20, y: my - 20 },
                                { x: mx + 20, y: my },
                                { x: mx, y: my + 20 },
                                { x: mx + 40, y: my + 40 },
                                { x: mx + 30, y: my + 50 },
                                { x: mx, y: my + 70 },
                                { x: mx - 30, y: my + 50 },
                                { x: mx, y: my + 30 },
                                { x: mx + 30, y: my + 50 },
                                { x: mx + 10, y: my + 90 },
                                { x: mx - 10, y: my + 110 },
                                { x: mx - 40, y: my + 150 },
                                { x: mx - 50, y: my + 180 },
                                { x: mx - 50, y: my + galaga.sceneH+20 }

                            ],
                            autoRotate: ["x","y","mrotate",90,false]
                        },
                        ease: Linear.easeNone,
                        onComplete: function(monster, mx, my){
                            monster.x = mx;
                            monster.y = my - 50;
                            var tween1 = new TweenMax(monster, 1.0, {
                                x: mx,
                                y: my,
                                ease: Linear.easeNone
                            });

                            var tween2 = new TweenMax(monster, 0.1, {
                                mrotate: 0,
                                ease: Linear.easeNone
                            });

                            var tl = new TimelineMax();
                            tl.add(tween1);
                            tl.add(tween2);
                        },
                        onCompleteParams: [monster, mx, my]
                    });
                }





            }//end for

        }


    }



});












