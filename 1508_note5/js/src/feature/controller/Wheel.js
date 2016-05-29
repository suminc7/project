



define([
    ""
], function () {

    //
    //var window = parent.window || window;
    //var document = parent.document || document;


    $(document).keydown(function(e){
        var rolled = 0;
        if (e.keyCode == 37){
            rolled = 3;
            move(rolled);
        }else if(e.keyCode == 39){
            rolled = -3;
            move(rolled);
        }
    });




    var wheelCount = 0, wheelOffsetArr = [], winWid, winHei, scrollTop, parents;

    function MouseScroll (event) {



        event.preventDefault ? event.preventDefault() : event.returnValue = false;


        var rolled = 0;
        if ('wheelDelta' in event) {
            rolled = event.wheelDelta;
        }else{
            rolled = -40 * event.detail;
        }

        //console.log('isWheel:'+exports.isWheel);

        move(rolled);
    }

    function move(rolled){



        if(!exports.isWheel){

            scrollTop = parents.scrollTop;

            var hei = 0, i, maxHei = 0;
            if(rolled > 0){
                wheelCount--;
                if(wheelCount < 0){
                    wheelCount = 0;
                    return;
                }
            }else{
                wheelCount++;
                if(wheelCount >= wheelOffsetArr.length){
                    wheelCount = wheelOffsetArr.length-1;
                    return;
                }
            }

            for (i=0;i<wheelOffsetArr.length;i++){
                if(i < wheelCount){
                    hei += wheelOffsetArr[i];
                }
                maxHei += wheelOffsetArr[i];
                //wheelCount 높이만큼 재설정
                if(maxHei - scrollTop > 0){
                    if(maxHei - scrollTop < winWid && maxHei - scrollTop < winHei){
//                    console.log("maxHei - scrollTop (down) :"+(maxHei - scrollTop));
                        if(rolled > 0){
                            hei = maxHei - wheelOffsetArr[i];
                            wheelCount = i;
                            break;
                        }else{
                            hei = maxHei;
                            wheelCount = ++i;
                            break;
                        }

                    }
                }

            }



            parents.startWheelStep(wheelCount);




            TweenLite.to(parents, 1.3, {scrollTop:hei, ease:Power1.easeInOut, onUpdate:updateParent, onComplete:function(){
                exports.isWheel = false;
                parents.endWheelStep(wheelCount);
            }});
            exports.isWheel = true;
        }

    }

    function updateParent() {
        parents.scroll();
    }


    var exports = {

        isWheel: false,

        init: function(p){

            parents = p;


            if(md.tablet()){

                //var sx, $box = $('.box');
                var sx, $box = $('#contents, .intro');
                $box.bind('touchstart', function(e) {
                    var event = e.originalEvent;
                    sx = event.touches[0].screenX;
                    //e.preventDefault();	//	이벤트취소
                });

                $box.bind('touchmove', function(e) {
                    var event = e.originalEvent;
                    var mx = event.touches[0].screenX;
                    if(sx - mx > 10){
                        move(-30);
                        event.preventDefault();
                    }else if(sx - mx < -10){
                        move(30);
                        event.preventDefault();
                    }
                    //event.preventDefault();
                });

                $box.bind('touchend', function(e) {

                });


            }else{
// for mouse scrolling in Firefox

            }

            var elem = $.browser.safari ? parent.document : document;
            if (elem.addEventListener) {    // all browsers except IE before version 9
                // Internet Explorer, Opera, Google Chrome and Safari
                elem.addEventListener ("mousewheel", MouseScroll, false);
                // Firefox
                elem.addEventListener ("DOMMouseScroll", MouseScroll, false);
            }
            else {
                if (elem.attachEvent) { // IE before version 9
                    elem.attachEvent ("onmousewheel", MouseScroll);
                }
            }



        },

        movePage: function(n){
            move(n);
        },

        setScroll: function(scroll){
            scrollTop = scroll;
        },

        setSize: function(wid, hei){

            winWid = wid;
            winHei = hei;

            //페이지 추가시 변경
            wheelOffsetArr = [
                winHei,
                winWid,//spen
                winWid,
                winWid,
                winWid,
                winHei,//design
                winWid,
                winWid,
                winWid,
                winHei,//pay
                winWid,
                winWid,
                winHei,//charge
                winWid,
                winWid,
                winHei,//camera
                winWid,
                winWid,
                winWid,
                winWid,
                winHei,//enter
                winWid,
                winHei,
                winHei,
                winHei,//perfo
                winWid,
                winWid,
                winWid,
                winWid,
                winHei
            ];




            var h = 0;
            for (var i=0;i<wheelCount;i++){
                h += wheelOffsetArr[i];
            }

            TweenLite.set(parents, {scrollTop:h });
        },

        setWheelCount: function(){
            var hei = 0, i;
            for (i=0;i<wheelOffsetArr.length;i++){
                hei += wheelOffsetArr[i];
                if(parents.scrollTop == hei){

                    wheelCount = ++i;

                    break;
                }
            }


            parents.endWheelStep(wheelCount);

        },

        getWheelCount: function(){
            return wheelCount;
        }


    };

    return exports;


});





