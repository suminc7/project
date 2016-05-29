
// namespace:
this.createjs = this.createjs||{};

(function() {
    "use strict";

    var stage, plane, monsterArr, planeContainer;

    function Missile() {
        this.DisplayObject_constructor();



        stage = galaga.stage;
        plane = galaga.plane;
        monsterArr = galaga.monsterArr;
        planeContainer = stage.getChildByName("planeContainer");


        var spriteSheet = new createjs.SpriteSheet({
            framerate: 30,
            "images": ["assets/galaga/images/missile.png"],
            "frames": {"regX": 2, "height": 10, "count": 1, "regY": 5, "width": 5},

            "animations": {
                "run": [0, 13, "run", 0.1],
                "jump": [26, 63, "jump"]
            }
        });

        this.spriteSheet = spriteSheet;


        galaga.SoundController.planeMissile();

    }
    var p = createjs.extend(Missile, createjs.Sprite);






    p.removeMissile = function(){

    }

    p.shooting = function() {


        var self = this;

        var update = function(){


            self.y -= 4;

            var len = monsterArr.length;
            for (var i = 0;i<len;i++){
                var monster = monsterArr[i];
                if(monster){
                    var mx = monster.x;
                    var my = monster.y;
                    var mrx = monster.spriteSheet._regX;
                    var mry = monster.spriteSheet._regY;
                    if (mx - mrx <= self.x && self.x <= mx + mrx && my - mry <= self.y && self.y <= my + mry)  {
                        createjs.Ticker.removeEventListener("tick", update);
                        planeContainer.removeChild(self);
                        monster.destroy(i);

                    }
                }

            }

            if(self.y < -10){
                createjs.Ticker.removeEventListener("tick", update);
                planeContainer.removeChild(self);

            }


        }


        createjs.Ticker.addEventListener("tick", update);
    };


    createjs.Missile = createjs.promote(Missile, "Sprite");
}());
