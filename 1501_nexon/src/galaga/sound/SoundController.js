
define([
    "",
    ""
], function () {

    var stage, monsterArr, sceneW, container;





    return {

        init: function(){

            createjs.Sound.registerSound("assets/galaga/sound/me_laser.mp3", "missile");
            createjs.Sound.registerSound("assets/galaga/sound/start.mp3", "start");
            createjs.Sound.registerSound("assets/galaga/sound/hit.mp3", "hit");
            createjs.Sound.registerSound("assets/galaga/sound/hit2.mp3", "hit2");
            createjs.Sound.registerSound("assets/galaga/sound/dead.mp3", "dead");
            createjs.Sound.registerSound("assets/galaga/sound/enemy.mp3", "enemy");
            createjs.Sound.registerSound("assets/galaga/sound/coin.mp3", "coin");

            //this.planeMissile();
        },

        gameStart: function(){
            createjs.Sound.play("start");
        },

        planeMissile: function(){
            createjs.Sound.play("missile");
        },

        monsterDestroy: function(color){
            if(color == 'green'){
                createjs.Sound.play("hit");
            }else if(color == 'red'){
                createjs.Sound.play("hit");
            }else if(color == 'blue'){
                createjs.Sound.play("hit2");
            }


        },

        planeDestroy: function(){
            createjs.Sound.play("dead");
        },

        enemy: function(){
            createjs.Sound.play("enemy");
        },
        coin: function(){
            createjs.Sound.play("coin");
        }

    };
});
