
define([
    "spark/MP3Player",
    "spark/Step6",
    "spark/ReVideo",
    "spark/PlayBar"
], function (MP3Player, Step6, ReVideo, PlayBar) {

    var $step5 = $('.step5');

    var $drag = $('.step5 #drag2');
    var $startDesc = $('.step5 .start-desc');

    var r,dragImg, createCheck = false, isFirst = false;


    var exports = {

        Step5Show: function(){
            //console.log('Step5Show');

            isFirst = false;
            MP3Player.loadMP3(5);
            ReVideo.play(2);


            $startDesc.show();
            $drag.show();
            $step5.show();

            if(ie8){

            }else{
                TweenMax.from($drag, 1, {autoAlpha:0});
                TweenMax.from($startDesc, 1, {autoAlpha:0});
                $startDesc.find('img').each(function(idx){
                    TweenMax.from(this, 0.8, {autoAlpha:0, y:20, delay:idx*0.15, clearProps:'all'});
                });
            }

            exports.createDrag();

        },

        createDrag: function(){

            var $self = this;

            if(createCheck){
                this.reset();
                return;
            }

            createCheck = true;

            r = Raphael("drag2");

            var x=130,y=125,ra=80,a1=90,a2=270;

            r.customAttributes.segment = function (x, y, r, a1, a2) {
                var flag = (a2 - a1) > 180,
                    clr = (a2 - a1) / 360;
                a1 = (a1 % 360) * Math.PI / 180;
                a2 = (a2 % 360) * Math.PI / 180;
                return {
                    path: [["M", x, y+ra], ["l", r * Math.cos(a1), Math.sin(a1)], ["A", r, r, 0, +flag, 1, x + r * Math.cos(a2), y + r * Math.sin(a2)]],
                    fill: "#FFF",
                    "fill-opacity": 0
                };
            };

            var p = r.path().attr({segment: [x, y, ra, a1, a2], stroke: "#fff", "stroke-width": 2, "stroke-dasharray":"--"});
            var len = p.getTotalLength();

            var e1 = r.circle(0,0,40).attr({stroke: "none", fill: "#FFF", opacity:0.3});
            r.circle(x,y-ra,12).attr({stroke: "#FFF", fill: "#FFF", opacity:1, "fill-opacity":0, "stroke-width": 1});
            r.circle(x,y-ra,4).attr({stroke: "none", fill: "#FFF", opacity:1});

            var subpathString = p.getSubpath(0, 0);
            var subPath = r.path(subpathString);
            subPath.attr({'stroke-width' : '2', 'stroke' : '#f4bc00'});

            r.circle(x,y+ra,10).attr({stroke: "none", fill: "#FFF"});

            dragImg = r.image(spark.path + "/images/step5/drag_02/DRAG0000.png", 40, 136, 100, 100);
            dragImg.attr({opacity:0});

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
            e.attr({along: 0});
            e.oy = 0;

            var m = 0;
            var start = function () {
                    this.oy = this.transform()[0][2] - (y-ra);
                    e.animate({r: 14}, 200, ">");
                    e1.animate({r: 30}, 200, ">");
                    dragImg.attr({opacity:0});
                    clearInterval($self.interval);
                    ReVideo.stop();
                    MP3Player.click();
                },
                move = function (dx, dy) {


                    var my = this.oy + dy;

                    var n = my/(ra*2);

                    if(n < 0){
                        n = 0;
                    }else if(n > 1){
                        n = 1;
                    }

                    if(n <= 0){
                        if(e.undrag) e.undrag();
                        tracking('2015spark-event-mylink');
                        Step6Start();
                        return;
                    }else{
                        m = 1-n;
                        if(e.attr) e.attr({along: m});
                    }

                },
                up = function () {
                    e.animate({r: 10}, 200, ">");
                    e1.animate({r: 40}, 200, ">");

                    if(m < 0.5){
                        e.animate({along: 0}, 600, "<>");
                    }else{
                        e.animate({along: 1}, 600, "<>", function(){
                            tracking('2015spark-event-mylink');
                            e.undrag();
                            Step6Start();
                        });
                    }
                };
            e.drag(move, start, up);

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
                    dragImg.attr({'src': spark.path + "/images/step5/drag_02/"+file+".png"});
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

        },

        Step5ReOn: function(){
            $step5.hide();
        },

        Step5ReOff: function(){
            $step5.show();
        },

        Step5Hide: function(){
            var self = this;
            MP3Player.outMP3();
            $step5.css('display','none');
            clearInterval(self.interval);
            ReVideo.stop();
            PlayBar.reset();
        },

        Step6Start: function(){

            if(!isFirst){
                setTimeout(function(){
                    window.thisMovie('player1').Step6Start(false);
                }, 1000);
                $step5.css('display','none');
                $('.spot4').find('.checked').css('display','block');
                isFirst = true;
            }

        }
    };



    window.Step5Show = exports.Step5Show;
    window.Step6Start = exports.Step6Start;
    window.Step5ReOn = exports.Step5ReOn;
    window.Step5ReOff = exports.Step5ReOff;
    window.Step5Hide = exports.Step5Hide;

    return exports;
});
