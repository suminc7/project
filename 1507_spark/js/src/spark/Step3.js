
define([
    "spark/MP3Player",
    "spark/Step4",
    "spark/Circle",
    "spark/ReVideo",
    "spark/PlayBar"
], function (MP3Player, Step4, Circle, ReVideo, PlayBar) {

    var $step3 = $('.step3');

    var $drag = $('.step3 #drag');
    var $startDesc = $('.step3 .start-desc');
    var e1, dragImg, createCheck = false, e1Check = false;



    var exports = {

        Step3Show: function(){
            //console.log('Step3Show');
            MP3Player.loadMP3(3);
            ReVideo.play(1);
            $step3.find('.circle').hide();
            $step3.show();

            if(ie8){

            }else{

                TweenMax.from($drag, 1, {autoAlpha:0});
                TweenMax.from($startDesc, 1, {autoAlpha:0});
                $startDesc.find('img').each(function(idx){
                    TweenMax.from(this, 0.8, {autoAlpha:0, y:20, delay:idx*0.15, clearProps:'all'});
                });
            }


            $startDesc.show();
            $drag.show();
            $step3.show();



            exports.createDrag();

        },

        createDrag: function(){
            var ax=43,ay=87,bx=159,by=22,cx=343,cy=33,zx=424,zy=164;

            var $self = this;


            if(createCheck){
                $self.reset();
                return;
            }

            createCheck = true;

            Raphael("drag", 480, 210, function () {

                this.circle(zx,zy,14).attr({stroke: "#FFF", fill: "#FFF", opacity:1, "fill-opacity":0, "stroke-width": 1});
                this.circle(zx,zy,4).attr({stroke: "none", fill: "#FFF", opacity:1});

                e1 = this.circle(0,0,40).attr({stroke: "none", fill: "#FFF", opacity:0.3});

                var r = this;
                var p = r.path([["M", ax, ay], ["C", bx, by, cx, cy, zx, zy]]).attr({stroke: "#FFF", opacity:1, "stroke-width": 2, "stroke-dasharray":"--"});
                var subpathString = p.getSubpath(0, 0);
                var subPath = r.path(subpathString);
                subPath.attr({'stroke-width' : '2', 'stroke' : '#f4bc00'});

                this.circle(ax,ay,10).attr({stroke: "none", fill: "#FFF"});

                dragImg = r.image(spark.path + "/images/step3/drag_01/DRAG0000.png", 10, 14, 150, 100);
                dragImg.attr({opacity:0});

                var len = p.getTotalLength();
                var e = r.circle(0,0,10).attr({stroke: "#f4bc00", "stroke-width": 10, fill: "#FFF"});


                r.customAttributes.along = function (v) {
                    var point = p.getPointAtLength(v * len);

                    subpathString = p.getSubpath(0, v * len);
                    subPath.attr('path', subpathString);

                    e1.transform("t" + [point.x, point.y]);

                    return {
                        transform: "t" + [point.x, point.y]
                    };
                };

                e.ox = 0;

                var n = 0;

                var start = function () {
                        ReVideo.stop();
                        this.ox = this.transform()[0][1] - ax;
                        e.animate({r: 14}, 200, ">");
                        e1.animate({r: 30}, 200, ">");
                        dragImg.attr({opacity:0});
                        clearInterval($self.interval);

                        e1Check = true;
                        MP3Player.click();
                    },
                    move = function (dx, dy) {

                        var mx = this.ox + dx;
                        if(mx < 0){
                            mx = 0;
                        }else if(mx > zx - ax){
                            mx = zx - ax;
                        }
                        n = mx/(zx - ax);

                        if(n == 1){
                            tracking('2015spark-event-citymode');
                            Step4Start();
                            e.undrag();
                        }
                        e.attr({along: n});
                    },
                    up = function () {
                        e.animate({r: 10}, 200, ">");
                        e1.animate({r: 40}, 200, ">");

                        if(n < 0.5){
                            e.animate({along: 0}, 600, "<>");
                        }else{
                            e.animate({along: 1}, 600, "<>", function(){
                                tracking('2015spark-event-citymode');
                                Step4Start();
                                e.undrag();
                            });
                        }
                    };

                e.mouseover(function () {
                    this[0].style.cursor = "pointer";
                });
                e.mouseout(function () {
                    this[0].style.cursor = "";

                });



                $self.intervalFunction = function(){
                    var dragImgCount = 0;
                    $self.interval = setInterval(function(){
                        var file = dragImgCount < 10 ? "DRAG000" + dragImgCount : "DRAG00" + dragImgCount;
                        dragImg.attr({'src': spark.path + "/images/step3/drag_01/"+file+".png"});
                        dragImgCount++;
                        if(dragImgCount > 19){
                            dragImgCount = 0;
                        }
                    },60);
                };


                $self.reset = function(){
                    //console.log('reset');

                    e.drag(move, start, up);
                    e.attr({along: 0});

                    setTimeout(function(){
                        e.animate({along: 1}, 1600, "<>", function(){
                            e1.animate({opacity: 0}, 600, "<>");
                            e.animate({opacity: 0}, 600, "<>", function(){
                                e.attr({along: 0});
                                e.animate({opacity: 1}, 600, "<>");
                                e1.animate({opacity: 0.3}, 600, "<>");
                                dragImg.animate({opacity: 1}, 600, "<>", $self.intervalFunction);
                            });
                        });
                    },600);
                };
                $self.reset();
            });
        },

        Step3OnButton: function(){



            Circle.init($step3);
            TweenMax.from('.step3 .circle', 0.3, {autoAlpha:0, clearProps:'all'});
            TweenMax.delayedCall(3, function(){ $('.step3 .circle').trigger('mouseleave'); });


            $startDesc.hide();
            $drag.hide();
            $step3.show();
        },
        Step3OffButton: function(){
            TweenMax.to('.step3 .circle', 0.3, {autoAlpha:0, onComplete:function(){
                $startDesc.hide();
                $drag.hide();
                $step3.hide();
            }});

        },

        Step3Hide: function(){
            var self = this;
            MP3Player.outMP3();
            $step3.css('display','none');
            clearInterval(self.interval);
            ReVideo.stop();
            PlayBar.reset();
        },

        Step4Start: function(){
            $('.spot2').find('.checked').css('display','block');
            window.thisMovie('player1').Step4Start(false);

        }
    };


    //exports.Step3Show();

    window.Step3Show = exports.Step3Show;
    window.Step3OnButton = exports.Step3OnButton;
    window.Step3OffButton = exports.Step3OffButton;
    window.Step3Hide = exports.Step3Hide;
    window.Step4Start = exports.Step4Start;

    return exports;
});
