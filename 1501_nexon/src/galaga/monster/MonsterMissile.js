
// namespace:
this.createjs = this.createjs||{};

(function() {
    "use strict";

    var stage, plane, monsterArr, stageH, monsterContainer;

    function MonsterMissile() {
        this.DisplayObject_constructor();

        var self = this;
        stage = galaga.stage;
        plane = galaga.plane;
        monsterArr = galaga.monsterArr;
        stageH = galaga.stageH;
        monsterContainer = stage.getChildByName("monsterContainer");




        var spriteSheet = new createjs.SpriteSheet({
            framerate: 30,
            "images": ["assets/galaga/images/monster_missile.png"],
            "frames": {"regX": 2, "height": 10, "count": 1, "regY": 5, "width": 5},

            "animations": {
                "run": [0, 13, "run", 0.1],
                "jump": [26, 63, "jump"]
            }
        });

        this.spriteSheet = spriteSheet;
    }
    var p = createjs.extend(MonsterMissile, createjs.Sprite);






    p.removeMissile = function(){

    }

    p.shooting = function() {


        var self = this;

        var nx = plane.x - self.x;

        var update = function(){


            self.y += 2.5;



            self.x += nx/100;


            if(plane){
                var mx = plane.x;
                var my = plane.y;
                var mrx = plane.spriteSheet._frameWidth/2;
                var mry = plane.spriteSheet._frameHeight/2;
                if (mx - mrx <= self.x && self.x <= mx + mrx && my - mry <= self.y && self.y <= my + mry)  {
                    createjs.Ticker.removeEventListener("tick", update);
                    monsterContainer.removeChild(self);
                    plane.destroy();
                }
            }

            if(self.y > stageH + 10){
                createjs.Ticker.removeEventListener("tick", update);
                monsterContainer.removeChild(self);

            }


        }


        createjs.Ticker.addEventListener("tick", update);
    };


    createjs.MonsterMissile = createjs.promote(MonsterMissile, "Sprite");
}());
