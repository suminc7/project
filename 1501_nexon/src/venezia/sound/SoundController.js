
define([
    "",
    ""
], function () {

    var stage, monsterArr, sceneW, container;





    return {

        init: function(){

            createjs.Sound.registerSound("assets/venezia/sound/hit.mp3", "hit");
            createjs.Sound.registerSound("assets/venezia/sound/block.mp3", "block");
            createjs.Sound.registerSound("assets/venezia/sound/end.mp3", "end");

            //this.planeMissile();
        },

        hit: function(){
            createjs.Sound.play("hit");
        },

        block: function(){
            createjs.Sound.play("block");
        },

        end: function(){
            createjs.Sound.play("end");
        }

    };
});
