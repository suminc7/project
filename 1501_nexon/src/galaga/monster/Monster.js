
// namespace:
this.createjs = this.createjs||{};

(function() {
    "use strict";

    var stage;

    var destroySpriteSheet = new createjs.SpriteSheet({
        framerate: 30,
        "images": ["assets/galaga/images/monster_destroy.png"],
        "frames": {"regX": 16, "height": 32, "count": 5, "regY": 16, "width": 32},
        "animations": {
            "destroy": [0, 4, "", 0.2]
        }
    });

    function Monster(spriteSheet) {

        stage = galaga.stage;


        this.DisplayObject_constructor();



        this.spriteSheet = spriteSheet;


        var self = this;
        this.mx = 0;
        this.my = 0;
        this.mrotate = 0;
        this.frameNum = 0;
        this.num = -1;
        this.color = '';

        //console.log(this.mrotate);

        this.compositeOperation = "lighter";

        var mrx = galaga.plane.spriteSheet._frameWidth/2;
        var mry = galaga.plane.spriteSheet._frameHeight/2;

        this.update = function(){

            //if(self.name == 'm1_0'){
            //    console.log(self.mrotate);
            //
            //}

            var offsetR = 30;
            var mrotate = self.mrotate;



            // -6/30 = -1 to -6/30 = 0
            // 15~45 to 30, 75~105 to 90
            var mr = Math.floor(mrotate/offsetR);
            if(mr < 0) mr = mr + 1;

            var remainder = mrotate % offsetR;
            if(remainder > 15){
                mr = mr + 1;
            }
            if(remainder < -15){
                mr = mr - 1;
            }

            mr = mr * offsetR;
            self.rotation = mr;


            var plane = galaga.plane;

            if(plane){
                var mx = plane.x;
                var my = plane.y;
                if (mx - mrx <= self.x && self.x <= mx + mrx && my - mry <= self.y && self.y <= my + mry)  {
                    createjs.Ticker.removeEventListener("tick", self.update);
                    self.destroy(self.num);
                    plane.destroy();
                }

            }

        };

        createjs.Ticker.addEventListener("tick", self.update);


    }
    var p = createjs.extend(Monster, createjs.Sprite);

    p.destroy = function(i){
        var self = this;
        function animationEnd(event){
            if (event.name == "destroy") {
                event.remove();

                if(self.color == 'green'){
                    //boss 이면 400점 추가
                    setTimeout(function(){

                        var ss = new createjs.SpriteSheet(galaga.textSprite);
                        var score = new createjs.Sprite(ss, 's400');
                        score.x = self.x;
                        score.y = self.y-10;
                        self.parent.addChild(score);
                        galaga.UIController.setScore(400);

                        //1초 후에 score removeChild
                        setTimeout(function(){
                            self.parent.removeChild(score);
                            event.currentTarget.parent.removeChild(event.currentTarget);
                            event.currentTarget = null;
                        }, 1000);
                    }, 100);
                }else{
                    event.currentTarget.parent.removeChild(event.currentTarget);
                    event.currentTarget = null;
                }

            }
        }

        this.attackNum++;


        if(this.attackNum == 1){
            //1이면 색만 변하고
            this.frameNum = this.frameNum + 8;
            this.gotoAndStop(this.currentFrame + 8);
        }else if(this.attackNum == 2){
            //2이면 destroy 모션후 삭제
            //clearInterval(this.setInterval);
            TweenMax.to(this, 0, {x:this.x, y:this.y});
            this.spriteSheet = destroySpriteSheet;
            this.on("animationend", animationEnd);
            this.gotoAndPlay("destroy");
            //createjs.Ticker.removeEventListener("tick", this.update);


            galaga.SoundController.monsterDestroy(this.color);


            galaga.liveMonsters = galaga.liveMonsters - 1;
            if(galaga.liveMonsters == 0){
                gameFinished(galaga.score);
            }


            galaga.monsterArr[i] = null;

            var score;
            if(0 <= i && i <= 3){
                score = 150;
            }else if(4 <= i && i <= 11){
                score = 80;
            }else if(12 <= i && i <= 19){
                score = 80;
            }else if(20 <= i && i <= 29){
                score = 50;
            }else if(30 <= i && i <= 39){
                score = 50;
            }

            galaga.UIController.setScore(score);


            //console.log(monsterArr);
        }


    }

    p.setPos = function(x, y){
        this.mx = x;
        this.my = y + 10;


    }




    createjs.Monster = createjs.promote(Monster, "Sprite");
}());
