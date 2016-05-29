
function Clip(){
    this.x = 0;
    this.y = 0;
    this.r = 20;
    this.nx = 0;
    this.hy = 0;
}







define([
    ""
], function () {


    var $canvas = $('#transition');
    var canvas = $canvas[0];
    var ctx = canvas.getContext ? canvas.getContext('2d') : null;

    var clipArr = [], totalClip = 0, nw = 0, nh = 0, winWid, winHei, isShow = false;


    var exports = {
        ox: 35,
        oy: 35,
        max: 35,

        setSize: function(wid, hei){

            winWid = wid;
            winHei = hei;

            $canvas.attr('width', winWid);
            $canvas.attr('height', winHei);

            nw = Math.floor(winWid / this.ox) + 2;
            nh = Math.floor(winHei / this.oy) + 2;

            totalClip = nw * nh;
        },

        createClip: function(){
            if(ctx) {
                clipArr = [];

                //            var offset = nw > nh ? nw : nh;
                var offset = nw;

                for (var i = 0; i < totalClip; i++) {
                    var clip = new Clip();
                    clip.x = this.ox * (i % offset);
                    clip.y = this.oy * Math.floor(i / offset);
                    clip.hy = (clip.y - winHei) * 0.01;
                    clip.nx = (clip.x - winWid) * 0.005;
                    clipArr.push(clip);
                }
            }
        },

        runClip: function(top){

            if(ctx){




                ctx.clearRect(0, 0, winWid, winHei);

                var ntop = top * 0.07;

                for (var i = 0;i < totalClip; i++){

                    //ctx.save();
                    ctx.beginPath();

                    var clip = clipArr[i];

                    var r = 0;
//                r =  (scrollTop + (clip.y)*0.2) * 0.30 + (clip.x * 0.005 - nw);
                    r =  ntop + clip.hy + clip.nx;

                    if(r > this.max){
                        r = this.max;
                    }else if(r < 0){
                        r = 0;
                    }

                    var cx = clip.x, cy = clip.y;

                    ctx.moveTo(cx, cy-r);
                    ctx.lineTo(cx-r, cy);
                    ctx.lineTo(cx, cy+r);
                    ctx.lineTo(cx+r, cy);
                    ctx.closePath();
//                ctx.arc(clip.x, clip.y, r, 0, Math.PI * 2, false);

                    ctx.fillStyle = 'white';
                    ctx.fill();

                    //ctx.restore();

                }
            }
        },
        show: function(zIdx){
            if(!isShow){
                isShow = true;
                TweenMax.set($canvas, { 'zIndex':zIdx, 'top':0});
            }

        },

        hide: function(){
            if(isShow){
                isShow = false;
                TweenMax.set($canvas, {'top':winHei});
            }

        }


    };

    return exports;


});













