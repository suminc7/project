
define([
    "galaga/monster/Monster",
    "galaga/monster/MonsterAnimation",
    "galaga/monster/MonsterAttackAnimation"
], function (Monster, MonsterAnimation, MonsterAttackAnimation) {



    var stage, monsterArr, sceneW, container;

    var monsterH = 35;
    var monsterXoffset = 0;


    return {

        init: function(){
            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            sceneW = galaga.sceneW;
            container = new createjs.Container();
            container.name = "monsterContainer";
            stage.addChild(container);

            this.createMonster1();
            this.createMonster2();
            this.createMonster3();
            this.initMonsters();
            this.monsterInterval();



            MonsterAnimation.init();
            MonsterAttackAnimation.init();
        },



        createMonster1 : function(){
            var m1SpriteSheet = new createjs.SpriteSheet({
                framerate: 30,
                "images": ["assets/galaga/images/monster01.png"],
                "frames": {"regX": 8, "height": 18, "count": 16, "regY": 9, "width": 17, margin: 0, spacing:7},
                "animations": {
                    "fly": [0, 1, "fly", 0.030],
                    "fly2": [8, 9, "fly2", 0.030]
                }
            });

            var m1Len = 4;
            for (var i=0;i<m1Len;i++){
                var monster = new createjs.Monster(m1SpriteSheet);
                monster.color = 'green';
                monster.attackNum = 0;
                monster.setPos(sceneW / 2 + (m1SpriteSheet._frameWidth * (i - m1Len/2) + m1SpriteSheet._frameWidth / 2) + monsterXoffset, monsterH);
                monster.x = sceneW/2;
                monster.y = -50;
                monster.name = "m1_"+i;
                container.addChild(monster);
                monsterArr.push(monster);

            }
        },

        createMonster2 : function(){
            var m1SpriteSheet = new createjs.SpriteSheet({
                framerate: 30,
                "images": ["assets/galaga/images/monster02.png"],
                "frames": {"regX": 8, "height": 18, "count": 8, "regY": 9, "width": 17, margin: 0, spacing:7},
                "animations": {
                    "fly": [0, 1, "fly", 0.030],
                    "fly2": [8, 9, "fly2", 0.030]
                }
            });


            var m1Len = 8;
            for (var i=0;i<m1Len;i++){
                var monster = new createjs.Monster(m1SpriteSheet);
                monster.color = 'red';
                monster.attackNum = 1;
                monster.setPos(sceneW / 2 + (m1SpriteSheet._frameWidth * (i - m1Len/2) + m1SpriteSheet._frameWidth / 2) + monsterXoffset, monsterH + 18);
                monster.x = sceneW/2;
                monster.y = -50;
                monster.name = "m2_"+i;
                container.addChild(monster);
                monsterArr.push(monster);
            }


            for (var i=0;i<m1Len;i++){
                var monster = new createjs.Monster(m1SpriteSheet);
                monster.color = 'red';
                monster.attackNum = 1;
                monster.setPos(sceneW / 2 + (m1SpriteSheet._frameWidth * (i - m1Len/2) + m1SpriteSheet._frameWidth / 2) + monsterXoffset, monsterH + 18 * 2);
                monster.x = sceneW/2;
                monster.y = -50;
                monster.name = "m2_"+i;
                container.addChild(monster);
                monsterArr.push(monster);
            }
        },

        createMonster3: function(){
            var m1SpriteSheet = new createjs.SpriteSheet({
                framerate: 30,
                "images": ["assets/galaga/images/monster03.png"],
                "frames": {"regX": 8, "height": 18, "count": 8, "regY": 9, "width": 17, margin: 0, spacing:7},
                "animations": {
                    "fly": [0, 1, "fly", 0.030],
                    "fly2": [8, 9, "fly2", 0.030]
                }
            });

            var m1Len = 10;
            for (var i=0;i<m1Len;i++){
                var monster = new createjs.Monster(m1SpriteSheet);
                monster.color = 'blue';
                monster.attackNum = 1;
                monster.setPos(sceneW / 2 + (m1SpriteSheet._frameWidth * (i - m1Len/2) + m1SpriteSheet._frameWidth / 2) + monsterXoffset, monsterH + 18 * 3);
                monster.x = sceneW/2;
                monster.y = -50;
                monster.name = "m2_"+i;
                container.addChild(monster);
                monsterArr.push(monster);
            }


            for (var i=0;i<m1Len;i++){
                var monster = new createjs.Monster(m1SpriteSheet);
                monster.color = 'blue';
                monster.attackNum = 1;
                monster.setPos(sceneW / 2 + (m1SpriteSheet._frameWidth * (i - m1Len/2) + m1SpriteSheet._frameWidth / 2) + monsterXoffset, monsterH + 18 * 4);
                monster.x = sceneW/2;
                monster.y = -50;
                monster.name = "m2_"+i;
                container.addChild(monster);
                monsterArr.push(monster);
            }
        },

        initMonsters: function(){
            for (var i=0;i<monsterArr.length;i++){
                var monster = monsterArr[i];
                monster.num = i;
            }
            galaga.liveMonsters = monsterArr.length;
        },




        monsterInterval: function(){

            var intervalNum = 0;
            var moveNumStep1 = 3;
            var moveNumStep2 = -1;
            var movex = true;


            //animation
            var moveStep = 1;



            //step2
            var moveAniArrL = [20, 30, 4, 12, 21, 31, 5, 13, 22, 32, 6, 14, 23, 33, 7, 15, 24, 34];
            var moveAniArrR = [29, 39, 11, 19, 28, 38, 10, 18, 27, 37, 9, 17, 26, 36, 8, 16, 25, 35];
            var moveAniOffset = [5, 5, 5, 5, 5, 5, 5, 4, 4, 4, 3, 3, 3, 3, 3, 3, 3, 3];



            setInterval(function(){
                //날개짓 에니메이션
                intervalNum++;

                var i = 0, monster;


                if(intervalNum == 1){
                    for (i = 0;i<monsterArr.length;i++){
                        monster = monsterArr[i];
                        if( monster ) monster.gotoAndStop(monster.frameNum + 1);
                    }
                }else if(intervalNum == 2){
                    for (i = 0;i<monsterArr.length;i++){
                        monster = monsterArr[i];
                        if( monster ) monster.gotoAndStop(monster.frameNum);
                    }
                    intervalNum = 0;
                }


                if(moveStep == 1){

                    if(moveNumStep1 == 8){
                        moveNumStep1 = 7;
                        movex = false;
                    }else if(moveNumStep1 == 0){
                        moveNumStep1 = 1;
                        movex = true;
                    }else{
                        moveNumStep1 = movex ? moveNumStep1 + 1 : moveNumStep1 - 1;
                    }
                    for (i = 0;i<monsterArr.length;i++){
                        monster = monsterArr[i];
                        if( monster  && !TweenMax.isTweening(monster) ) monster.x = monster.mx - (moveNumStep1-4) * 2;
                    }


                }else{

                    if(moveNumStep2 == 0){
                        moveNumStep2 = 1;
                        movex = true;
                    }else if(moveNumStep2 == 5){
                        moveNumStep2 = 4;
                        movex = false;
                    }else{
                        moveNumStep2 = movex ? moveNumStep2 + 1 : moveNumStep2 - 1;
                    }

//                console.log(moveNumStep2);

                    for(i=0;i<moveAniOffset.length;i++){

                        var offset = (moveAniOffset[i] - moveNumStep2);
                        offset = offset > 0 ? offset : 0;
                        //if(i == 7)console.log(offset);
                        //offset = Math.floor(offset);

//                    monster = monsterArr[moveAniArrL[i]];
//                    monster.x = monster.mx - offset;
//                    monster = monsterArr[moveAniArrR[i]];
//                    monster.x = monster.mx + offset;

//                    if(movex){
//                        moveAniOffset[i] = moveAniOffset[i] + 1;
//                    }else{
//                        moveAniOffset[i] = moveAniOffset[i] - 1;
//                    }
                    }



                }




            }, 600);



        }

    }



});
