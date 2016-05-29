



define([
    ""
], function () {

    var imgArr;

    var $movingInner = $(' .moving-image-inner ');
    var imgWid = 1480;
    var imgHei = 920;
    var wid = 1280;
    var hei = 720;
    var halfWid = imgWid/2;
    var halfHei = imgHei/2;
    var canvas, ctx, $img, $step;


    if(ie8){
        $('.stepCanvas').hide();
    }else{
        $('.moving-image').hide();
    }



    var img;
    var arc = {r: 0};

    var runArc = function(){
        ctx.save();
        ctx.beginPath();
        ctx.arc(halfWid, halfHei, arc.r, 0, Math.PI * 2, false);
        ctx.clip();
        ctx.drawImage(img, 0, 0);
        ctx.restore();
    };
    var closeArc = function(){
        ctx.save();
        ctx.beginPath();
        ctx.globalCompositeOperation = 'destination-out';
        ctx.arc(halfWid, halfHei, arc.r, 0, Math.PI * 2, false);
        ctx.clip();
        //ctx.drawImage(img, 0, 0);
        ctx.fill();
        ctx.restore();
    };

    var exports = {

        init: function($s){
            if(ie8){
                $step = $s;
            }else{
                canvas = $s.find('canvas')[0];
                ctx = canvas.getContext('2d');
                CanvasRenderingContext2D.imageSmoothingEnabled = true;
            }

        },


        run: function(circleIdx, subNum, imgURL){
            //console.log(n);
            $movingInner.show();

            if(ie8){
                var $movingImage = $step.find(' .moving-image ');
                $movingImage.hide();
                $movingImage.eq(circleIdx).show();

                $img = $step.find(' .moving-image ').eq(circleIdx).find('img');
                $img.hide();
                $img.eq(subNum).show();

            }else{

                arc.r = 0;



                img = document.createElement('img');
                img.onload = function () {
                    TweenMax.to(arc, 0.8, {r:800, ease:Power2.easeInOut, onUpdate:runArc});
                };
                img.src = imgURL;

                $(document).bind('mousemove', function(e){
                    var wid = $(window).width();
                    var hei = $(window).height();

                    //console.log(e);

                    TweenMax.to(canvas, 1, {x: (e.pageX - wid/2) * -0.05, y: (e.pageY - hei/2) * -0.05});

                });

            }

        },

        close: function(){

            if(ie8){
                $movingInner.hide();
            }else{
                arc.r = 0;
                TweenMax.to(arc, 0.8, {r:800, ease:Power2.easeInOut, onUpdate:closeArc, onComplete:function(){
                    $movingInner.hide();
                    TweenMax.to(canvas, 0, {x: 0, y: 0});
                    $(document).unbind('mousemove');
                }});

            }

        }
    };
    return exports;


});





