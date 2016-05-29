


define([

], function () {

    var stage, monsterArr, sceneW;

    //step1
    var n1ArrL = [24,25,34,35];
    var n1ArrR = [7,8,15,16];
    var n2ArrL = [0,6,1,9,2,14,3,17];
    var n2ArrR = [10, 11, 4, 5, 18, 19, 12, 13];
    var n3ArrL = [26,22,23,27,36,32,33,37];
    var n4ArrL = [28,20,21,29,38,30,31,39];
    var offset = 30;

    return {

        init: function () {

            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            sceneW = galaga.sceneW;

            this.startAnimation();
        },

        startAnimation: function(){
            var self = this;
            self.monsterAnimation1(n1ArrL, {t1:1.0, t2:0.6, t3:0.6});
            self.monsterAnimation2(n1ArrR, {t1:1.0, t2:0.6, t3:0.6});


            setTimeout(function(){
                self.monsterAnimation3(n2ArrL, {t1:1.2, t2:0.6});
            }, 3000);

            setTimeout(function(){
                self.monsterAnimation4(n2ArrR, {t1:1.2, t2:0.6});
            }, 5000);


            setTimeout(function(){
                self.monsterAnimation2(n3ArrL, {t1:1.2, t2:0.5, t3:0.6});
            }, 7000);

            setTimeout(function(){
                self.monsterAnimation1(n4ArrL, {t1:1.2, t2:0.5, t3:0.7});
            }, 9000);

        },

        monsterAnimation1: function(arr, time){

            for(var i = 0;i<arr.length;i++){
                var monster = monsterArr[arr[i]];
                //console.log(monster.mrotate);

                var bezTween = new TweenMax(monster, time.t1, {
                    bezier: {
                        type: "thru",
                        values: [
                            { x: sceneW/2+10, y: -50 },
                            { x: sceneW/2+20, y: 45 },
                            { x: sceneW/2-30, y: 70 },
                            { x: sceneW/2-60 , y: 80 }
                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0,
                    delay: i*0.2

                });
                var bezTween2 = new TweenMax(monster, time.t2, {
                    bezier: {
                        type: "cubic",
                        values: [
                            { x: sceneW/2-60, y: 80 },
                            { x: sceneW/2-90 , y: 80 },
                            { x: sceneW/2-90 , y: 150 },
                            { x: sceneW/2-60, y: 150}
                        ],

                        autoRotate: ["x","y","mrotate",90,false]
                    },

                    ease: Linear.easeNone,
                    repeat: 0
                });
                var bezTween3 = new TweenMax(monster, time.t3, {
                    bezier: {
                        type: "quadratic",
                        values: [
                            { x: sceneW/2-60, y: 150},
                            { x: sceneW/2-20, y: 150},
                            { x: monster.mx, y: monster.my}
                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    mrotate: 0,
                    ease: Linear.easeNone,
                    repeat: 0
                });

                var tween = new TweenMax(monster, 0.1, {
                    mrotate: 0,
                    ease: Linear.easeNone,
                    repeat: 0,
                    onComplete: function(){
                        var monster = this.target;
                        monster.isMoved = true;
                    }
                });

                var tl = new TimelineMax({onComplete:function(){
                    //console.log(this);
                }});
                tl.add(bezTween);
                tl.add(bezTween2);
                tl.add(bezTween3);
                tl.add(tween);



            }

        },

        monsterAnimation2: function(arr, time){

            for(var i = 0;i<arr.length;i++){
                var monster = monsterArr[arr[i]];

                var bezTween = new TweenMax(monster, time.t1, {
                    bezier: {
                        type: "thru",
                        values: [
                            { x: sceneW/2-10, y: -50 },
                            { x: sceneW/2-20, y: 45 },
                            { x: sceneW/2+30, y: 70 },
                            { x: sceneW/2+60 , y: 80 }
                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0,
                    delay: i*0.2

                });
                var bezTween2 = new TweenMax(monster, time.t2, {
                    bezier: {
                        type: "cubic",
                        values: [
                            { x: sceneW/2+60, y: 80 },
                            { x: sceneW/2+90 , y: 80 },
                            { x: sceneW/2+90 , y: 150 },
                            { x: sceneW/2+60, y: 150}
                        ],

                        autoRotate: ["x","y","mrotate",90,false]
                    },

                    ease: Linear.easeNone,
                    repeat: 0
                });
                var bezTween3 = new TweenMax(monster, time.t3, {
                    bezier: {
                        type: "quadratic",
                        values: [
                            { x: sceneW/2+60, y: 150},
                            { x: sceneW/2+20, y: 150},
                            { x: monster.mx, y: monster.my}
                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0
                });

                var tween = new TweenMax(monster, 0.1, {
                    mrotate: 0,
                    ease: Linear.easeNone,
                    repeat: 0
                });

                var tl = new TimelineMax({});
                tl.add(bezTween);
                tl.add(bezTween2);
                tl.add(bezTween3);
                tl.add(tween);

            }

        },


        monsterAnimation3: function(arr, time){

            for(var i = 0;i<arr.length;i++){
                var monster = monsterArr[arr[i]];

                //TweenMax.set(monster, {
                //    x: -20, y: 190
                //});

                var bezTween = new TweenMax(monster, time.t1, {
                    bezier: {
                        type: "quadratic",
                        values: [
                            { x: 0, y: 190 },
                            { x: galaga.sceneW/2-35, y: 190 },
                            { x: galaga.sceneW/2-35, y: 120 },
                            { x: galaga.sceneW/2-35, y: 80 },
                            { x: galaga.sceneW/2-65 , y: 80 },
                            { x: galaga.sceneW/2-95 , y: 80 },
                            { x: galaga.sceneW/2-95 , y: 120 },
                            { x: galaga.sceneW/2-95 , y: 150 },
                            { x: galaga.sceneW/2-65 , y: 150 }

                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0,
                    delay: i*0.15

                });

                var bezTween3 = new TweenMax(monster, time.t2, {
                    bezier: {
                        type: "quadratic",
                        values: [
                            { x: galaga.sceneW/2-65 , y: 150 },
                            { x: galaga.sceneW/2-35, y: 150},
                            { x: monster.mx, y: monster.my}
                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0
                });

                var tween = new TweenMax(monster, 0.1, {
                    mrotate: 0,
                    ease: Linear.easeNone,
                    repeat: 0
                });


                var tl = new TimelineMax({});
                tl.add(bezTween);
                tl.add(bezTween3);
                tl.add(tween);


            }

        },

        monsterAnimation4: function(arr, time){

            for(var i = 0;i<arr.length;i++){
                var monster = monsterArr[arr[i]];

                //TweenMax.set(monster, {
                //    x: sceneW+20, y: 190
                //});


                var bezTween = new TweenMax(monster, time.t1, {
                    bezier: {
                        type: "quadratic",
                        values: [
                            { x: galaga.sceneW, y: 190 },
                            { x: galaga.sceneW/2+35, y: 190 },
                            { x: galaga.sceneW/2+35, y: 120 },
                            { x: galaga.sceneW/2+35, y: 80 },
                            { x: galaga.sceneW/2+65 , y: 80 },
                            { x: galaga.sceneW/2+95 , y: 80 },
                            { x: galaga.sceneW/2+95 , y: 120 },
                            { x: galaga.sceneW/2+95 , y: 150 },
                            { x: galaga.sceneW/2+65 , y: 150 }

                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0,
                    delay: i*0.15

                });

                var bezTween3 = new TweenMax(monster, time.t2, {
                    bezier: {
                        type: "quadratic",
                        values: [
                            { x: galaga.sceneW/2+65 , y: 150 },
                            { x: galaga.sceneW/2+35, y: 150},
                            { x: monster.mx, y: monster.my}
                        ],
                        autoRotate: ["x","y","mrotate",90,false]
                    },
                    ease: Linear.easeNone,
                    repeat: 0
                });

                var tween = new TweenMax(monster, 0.1, {
                    mrotate: 0,
                    ease: Linear.easeNone,
                    repeat: 0
                });


                var tl = new TimelineMax({});
                tl.add(bezTween);
                tl.add(bezTween3);
                tl.add(tween);


            }

        }



    }



});












