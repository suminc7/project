
// namespace:
this.createjs = this.createjs||{};

(function() {
    "use strict";

    var self, stage, plane, monsterArr, sceneW, planeContainer;

    var destroySpriteSheet = new createjs.SpriteSheet({
        framerate: 30,
        "images": ["assets/galaga/images/plane_destroy.png"],
        "frames": {"regX": 8, "height": 32, "count": 4, "regY": 8, "width": 32},
        "animations": {
            "destroy": [0, 3, "", 0.2]
        }
    });



    function Plane() {
        this.DisplayObject_constructor();




        self = this;
        sceneW = galaga.sceneW;
        stage = galaga.stage;
        plane = galaga.plane;
        monsterArr = galaga.monsterArr;

        planeContainer = stage.getChildByName("planeContainer");

        this.wid = 17;
        this.hei = 18;
        this.regX = 8;
        this.regY = 9;
        this.isMissile = false;
        this.compositeOperation = "lighter";


        $(document).bind('keydown', function(e){
            switch(e.which) {
                case 37: // left
                    self.nx = -1.5;
                    break;
                case 39: // right
                    self.nx = 1.5;
                    break;
                default: return; // exit this handler for other keys
            }
            e.preventDefault(); // prevent the default action (scroll / move caret)


        });
        $(document).bind('keyup', function(e){
            switch(e.which) {
                case 37: // left
                    if(self.nx == -1.5){
                        self.nx = 0;
                    }
                    break;
                case 39: // right
                    if(self.nx == 1.5){
                        self.nx = 0;
                    }
                    break;
                case 32: // space

                    if(self.isMissile){
                        return;
                    }

                    var missile = new createjs.Missile();
                    missile.x = self.x;
                    missile.y = self.y - 15;
                    planeContainer.addChild(missile);
                    missile.shooting();

                    self.isMissile = true;

                    setTimeout(function(){
                        self.isMissile = false;
                    }, 300);
                    break;

                default: return;
            }
            e.preventDefault();


        });


        var spriteSheet = new createjs.SpriteSheet({
            framerate: 30,
            "images": ["assets/galaga/images/plane.png"],
            "frames": {"regX": 0, "height": self.hei, "count": 14, "regY": 0, "width": self.wid, margin: 0, spacing:7},
            "animations": {
                "run": [0, 13, "run", 0.1]
            }
        });



        this.spriteSheet = spriteSheet;
        this.nx = 0;



        var sw = sceneW;
        this.update = function(){
            //
            self.x += self.nx;
            if(self.x < self.wid){
                self.x = self.wid;
            }else if(self.x > sw - self.wid){
                self.x = sw - self.wid;
            }

        };

        createjs.Ticker.addEventListener("tick", this.update);



    }
    var p = createjs.extend(Plane, createjs.Sprite);

    p.destroy = function(){
        var self = this;

        function animationEnd(event){
            if (event.name == "destroy") {
                event.remove();
                planeContainer.removeChild(self);
                galaga.UIController.reReady();
            }
        }

        galaga.plane = null;

        this.spriteSheet = destroySpriteSheet;
        this.on("animationend", animationEnd);
        this.gotoAndPlay("destroy");

        $(document).unbind( "keydown" );
        $(document).unbind( "keyup" );
        createjs.Ticker.removeEventListener("tick", this.update);

        galaga.SoundController.planeDestroy();


    }


    createjs.Plane = createjs.promote(Plane, "Sprite");
}());
