







requirejs.config({

    baseUrl: "js/src",
    urlArgs: "bust=" + (new Date()).getTime(),
    paths: {

        fit: '../../js/vendor/fit.min',
        text: '../../js/vendor/text'
    }

});

require([
    "text!../../featureContents.jsp",
    'fit'

], function (tag) {


    $('#contents').append(tag);


    require([
        'feature/controller/Clips',
        'feature/controller/Wheel',
        'feature/controller/Video',
        'feature/GNB',
        'feature/Menu',
        'feature/Intro',
        'feature/BottomBtn'
    ], function (Clips, Wheel, Video, GNB, Menu, Intro, BottomBtn) {


        var $window = $(parent.window), $canvas = $('#transition');
        var $html = $('html'), $wrap = $('#wrap');

        var $box = $('.box');
        var $boxInner = $('.box .inner');
        var $boxInnerItem = $('.box .inner .item');

        $box.each(function(i){
            $(this).data('idx', i);
        });


        if(ie8){

            $boxInnerItem.addClass('white');
            //$boxInnerItem.css({'background-color': 'white'});
        }



        var $spen = $('.spen'), $spenInner = $spen.find('.inner'), $spenDesc = $spenInner.find('.desc'), $spenVideo1 = $spen.find('.video');
        var $design = $('.design'), $designInner = $design.find('.inner'), $designDesc = $designInner.find('.desc'), $designVideo1 = $design.find('.video');
        var $pay = $('.pay'), $payInner = $pay.find('.inner'), $payDesc = $payInner.find('.desc');
        var $charge = $('.charge'), $chargeInner = $charge.find('.inner'), $chargeDesc = $chargeInner.find('.desc');
        var $camera = $('.camera'), $cameraInner = $camera.find('.inner'), $cameraDesc = $cameraInner.find('.desc');
        var $enter = $('.entertainment'), $enterInner = $enter.find('.inner'), $enterDesc = $enterInner.find('.desc'), $enterLeft = $enterInner.find('.bg-left'), $enterRight = $enterInner.find('.bg-right'), $enterSlideInner = $enterInner.find('.slide-inner');
        var $perfo = $('.performance'), $perfoInner = $perfo.find('.inner'), $perfoDesc = $perfoInner.find('.desc');
        var $video = $('.video');

        var winWid = 0, winHei = 0;
        var offset1 = 0, offset2 = 0, offset3 = 0, offset4 = 0, offset5 = 0, offset6 = 0, offset7 = 0;
        var offset8 = 0, offset9 = 0, offset10 = 0, offset11 = 0, offset12 = 0, offset13 = 0, offset14 = 0, offset15 = 0;
        var px = 0.2, py = -1.2;

        var beforeStep = -1;



        var exports = {

            winWid: 0,
            winHei: 0,
            scrollTop: 0,
            scrollObj: $wrap,

            setSize: function(){

                this.winWid = winWid = $html.width();
                this.winHei = winHei = $html.height();


                $box.width(winWid).height(winHei);
                $boxInner.width(10000).height(winHei);
                $boxInnerItem.width(winWid).height(winHei);

                //페이지 추가시 변경
                //console.log(parent.$('.nav').height());
                offset1 = winHei;
                offset2 = offset1 + winWid + winWid + winWid + winWid;//spen
                offset3 = offset2 + winHei;
                offset4 = offset3 + winWid + winWid + winWid;//design
                offset5 = offset4 + winHei;
                offset6 = offset5 + winWid + winWid;//pay
                offset7 = offset6 + winHei;
                offset8 = offset7 + winWid + winWid;//charging
                offset9 = offset8 + winHei;
                offset10 = offset9 + winWid + winWid + winWid + winWid;//camera
                offset11 = offset10 + winHei;
                offset12 = offset11 + winWid + winHei + winHei;//entertainment
                offset13 = offset12 + winHei;
                offset14 = offset13 + winWid + winWid + winWid + winWid;//performance
                offset15 = offset14 + winHei;

                Wheel.setSize(winWid, winHei);
                Clips.setSize(winWid, winHei);
                Clips.createClip();

                this.setAbsoluteOffset();

                if(!ie8){

                    $boxInnerItem.find('.px').each(function(){

                        var idx = $(this).parent().parent().parent().index();
                        //console.log(idx*winWid*0.1);
                        TweenMax.set($(this), {'x': idx*winWid * px});
                    });
                }
            },

            setAbsoluteOffset: function(){

                //TweenMax.set($spen, {'position': 'absolute', 'top':offset1, 'left':0});
                //TweenMax.set($design, {'position': 'absolute', 'top':offset3, 'left':0});
                //TweenMax.set($pay, {'position': 'absolute', 'top':offset5, 'left':0});

                $spen.data('myTop', offset1);
                $design.data('myTop', offset3);
                $pay.data('myTop', offset5);
                $charge.data('myTop', offset7);
                $camera.data('myTop', offset9);
                $enter.data('myTop', offset11);
                $perfo.data('myTop', offset13);

            },

            scroll: function(){
                if(GNB.clicked){
                    return;
                }

                //var myTop = this.scrollTop = $wrap.scrollTop();
                var myTop = this.scrollTop, mt, os;

                if(0 == myTop) {
                    Clips.hide();
                }else if(0 < myTop && myTop < offset1){

                    //GNB.setPageIdx(0);
                    Clips.runClip(myTop);
                    if(0 < myTop) Clips.show(50);


                    mt = offset1 - myTop;
                    //TweenMax.set($introUI, {'y': -myTop});

                    TweenMax.set($spen, {'position': 'absolute', 'top':mt + mt * 1.5, display:'block'});
                    TweenMax.set($spenInner, {x:0});
                    if(!ie8)TweenMax.set($spenDesc, {'y': mt * py});


                }else if(offset1 <= myTop && myTop < offset2){

                    //GNB.setPageIdx(1);

                    mt = offset1 - myTop;
                    TweenMax.set($spen, {'position':'absolute','top':0, display:'block'});
                    TweenMax.set($spenInner, {'x': mt});
                    if(!ie8)TweenMax.set($spenDesc, {'x': mt * px, y:0});

                    Clips.hide();



                }else if(offset2 <= myTop && myTop < offset3){
                    //spen up, design up

                    //GNB.setPageIdx(1);

                    mt = offset3 - myTop;
                    os = offset1 - offset2;
                    TweenMax.set($spen, {'position':'absolute', 'top': 0, display:'block'});
                    TweenMax.set($spenInner, {'x': os});
                    if(!ie8)TweenMax.set($spenDesc, {'x': os * px, y:0});

                    TweenMax.set($design, {'position': 'absolute', 'top':mt + mt*1.5, display:'block'});
                    TweenMax.set($designInner, {'x': 0});
                    if(!ie8)TweenMax.set($designDesc, {'y': mt * py});

                    Clips.runClip(myTop-offset2);
                    if(offset2 < myTop) Clips.show(150);



                }else if(offset3 <= myTop && myTop < offset4){

                    //design up
                    //GNB.setPageIdx(2);

                    mt = offset3 - myTop;

                    TweenMax.set($spen, {'position': 'absolute', 'top':-offset3, display:'none'});

                    TweenMax.set($design, {'position':'absolute','top':0, display:'block'});
                    TweenMax.set($designInner, {'x': mt});
                    if(!ie8)TweenMax.set($designDesc, {'x': mt * px, y:0});
                    Clips.hide();


                }else if(offset4 <= myTop && myTop < offset5){

                    //spen up, pay up

                    //GNB.setPageIdx(2);

                    mt = offset5 - myTop;
                    os = offset3 - offset4;

                    TweenMax.set($design, {'position':'absolute', 'top': 0, display:'block'});
                    TweenMax.set($designInner, {'x': os});
                    if(!ie8)TweenMax.set($designDesc, {'x': os * px, y:0});

                    TweenMax.set($pay, {'position': 'absolute', 'top':mt + mt*1.5, display:'block'});
                    TweenMax.set($payInner, {'x': 0});
                    if(!ie8)TweenMax.set($payDesc, {'y': mt * py});

                    Clips.runClip(myTop-offset4);
                    if(offset4 < myTop) Clips.show(250);


                }else if(offset5 <= myTop && myTop < offset6){

                    //GNB.setPageIdx(3);

                    mt = offset5 - myTop;

                    TweenMax.set($design, {'position': 'absolute', 'top':-offset3, display:'none'});

                    TweenMax.set($pay, {'position':'absolute','top':0});
                    TweenMax.set($payInner, {'x': mt});
                    if(!ie8)TweenMax.set($payDesc, {'x': mt * px, y:0});
                    Clips.hide();

                }else if(offset6 <= myTop && myTop < offset7){

                    //GNB.setPageIdx(3);

                    mt = offset7 - myTop;
                    os = offset5 - offset6;

                    TweenMax.set($pay, {'position':'absolute', 'top': 0, display:'block'});
                    TweenMax.set($payInner, {'x': os});
                    if(!ie8)TweenMax.set($payDesc, {'x': os * px, y:0});

                    TweenMax.set($charge, {'position': 'absolute', 'top':mt + mt * 1.5, display:'block'});
                    TweenMax.set($chargeInner, {'x': 0});
                    if(!ie8)TweenMax.set($chargeDesc, {'y': mt * py});

                    Clips.runClip(myTop-offset6);
                    if(offset6 < myTop) Clips.show(350);

                }else if(offset7 <= myTop && myTop < offset8){

                    //GNB.setPageIdx(4);

                    mt = offset7 - myTop;

                    TweenMax.set($pay, {'position': 'absolute', 'top':-offset5, display:'none'});

                    TweenMax.set($charge, {'position':'absolute','top':0, display:'block'});
                    TweenMax.set($chargeInner, {'x': mt});
                    if(!ie8)TweenMax.set($chargeDesc, {'x': mt * px, y:0});
                    Clips.hide();

                }else if(offset8 <= myTop && myTop < offset9){
                    //camera
                    //GNB.setPageIdx(4);

                    mt = offset9 - myTop;
                    os = offset7 - offset8;

                    TweenMax.set($charge, {'position':'absolute', 'top': 0, display:'block'});
                    TweenMax.set($chargeInner, {'x': os});
                    if(!ie8)TweenMax.set($chargeDesc, {'x': os * px, y:0});

                    TweenMax.set($camera, {'position': 'absolute', 'top':mt + mt * 1.5, display:'block'});
                    TweenMax.set($cameraInner, {'x': 0});
                    if(!ie8)TweenMax.set($cameraDesc, {'y': mt * py});

                    Clips.runClip(myTop-offset8);
                    if(offset8 < myTop) Clips.show(450);

                }else if(offset9 <= myTop && myTop < offset10){

                    //GNB.setPageIdx(5);

                    mt = offset9 - myTop;
                    os = offset7 - offset8;

                    TweenMax.set($charge, {'position': 'absolute', 'top':-offset7, display:'none'});

                    TweenMax.set($camera, {'position':'absolute','top':0, display:'block'});
                    TweenMax.set($cameraInner, {'x': mt});
                    if(!ie8)TweenMax.set($cameraDesc, {'x': mt * px, y:0});
                    Clips.hide();

                }else if(offset10 <= myTop && myTop < offset11){
                    //entertainment
                    //GNB.setPageIdx(5);

                    mt = offset11 - myTop;
                    os = offset9 - offset10;

                    TweenMax.set($camera, {'position':'absolute', 'top': 0, display:'block'});
                    TweenMax.set($cameraInner, {'x': os});
                    if(!ie8)TweenMax.set($cameraDesc, {'x': os * px, y:0});

                    TweenMax.set($enter, {'position': 'absolute', 'top':mt + mt*1.5, display:'block'});
                    TweenMax.set($enterInner, {'x': 0});
                    if(!ie8)TweenMax.set($enterDesc, {'y': mt * py});

                    Clips.runClip(myTop-offset10);
                    if(offset10 < myTop) Clips.show(550);

                }else if(offset11 <= myTop && myTop < offset12){

                    //GNB.setPageIdx(6);

                    mt = offset11 - myTop;
                    mt = mt < -winWid ? -winWid : mt;

                    TweenMax.set($camera, {'position': 'absolute', 'top':-offset9, display:'none'});

                    TweenMax.set($enter, {'position':'absolute','top':0, display:'block'});
                    TweenMax.set($enterInner, {'x': mt});
                    if(!ie8)TweenMax.set($enterDesc, {'x': mt * px, y:0});


                    TweenMax.set($enterRight, {'y': offset11 - myTop + winWid});
                    TweenMax.set($enterLeft, {'y': myTop - offset11 - winWid});
                    //var n = (offset11 - myTop + winWid) / -winHei * 274;
                    //if(0 <= n)TweenMax.set($enterSlideInner, {'x': -n});


                    Clips.hide();

                }else if(offset12 <= myTop && myTop < offset13){
                    //performance
                    //GNB.setPageIdx(6);

                    mt = offset13 - myTop;
                    os = offset11 - offset12;
                    os = os < -winWid ? -winWid : os;

                    TweenMax.set($enter, {'position':'absolute', 'top': 0, display:'block'});
                    TweenMax.set($enterInner, {'x': os});
                    if(!ie8)TweenMax.set($enterDesc, {'x': os * px, y:0});


                    TweenMax.set($enterRight, {'y': offset11 - offset12 + winWid});
                    TweenMax.set($enterLeft, {'y': offset12 - offset11 - winWid});
                    //var n = (offset11 - offset12 + winWid) / -winHei * 274;
                    //if(0 <= n)TweenMax.set($enterSlideInner, {'x': -n});


                    TweenMax.set($perfo, {'position': 'absolute', 'top':mt + mt*1.5, display:'block'});
                    TweenMax.set($perfoInner, {'x': 0});
                    if(!ie8)TweenMax.set($perfoDesc, {'y': mt * py});

                    Clips.runClip(myTop-offset12);
                    if(offset12 < myTop) Clips.show(650);

                }else if(offset13 <= myTop && myTop < offset14){

                    //GNB.setPageIdx(7);

                    mt = offset13 - myTop;

                    TweenMax.set($enter, {'position': 'absolute', 'top':-offset11, display:'none'});

                    TweenMax.set($perfo, {'position':'absolute','top':0, display:'block'});
                    TweenMax.set($perfoInner, {'x': mt});
                    if(!ie8)TweenMax.set($perfoDesc, {'x': mt * px, y:0});
                    Clips.hide();

                }


                if(myTop == 0){
                    Intro.show();
                }else if(0 < myTop && myTop < offset1){
                    Intro.show();
                }else{
                    Intro.hide();
                }


                Wheel.setScroll(myTop);

            },

            resize: function(){
                this.setSize();
                this.scroll();
            },


            //call GNB
            setScrollTop: function(top){
                this.scrollTop = top;
                this.scroll();
                Wheel.setWheelCount();
            },


            startWheelStep: function(step){

                console.log('startWheelStep:'+step);

                if(step == 22){
                    if(!ie8)TweenMax.to($enter.find('.center-phone'), 1.3, {'x':130, 'rotation': -90});
                    TweenMax.to($enter.find('.phone2'), 1, {'autoAlpha': 0});
                    TweenMax.to($enter.find('.phone4'), 1, {'autoAlpha': 0});


                    TweenMax.to($enterSlideInner, 1.3, {'x': 0, ease:Power1.easeInOut});


                    if(ie8){
                        $enter.find('.slide').hide();
                        $enter.find('.phone').hide();
                        $enter.find('.phone2').hide();
                        $enter.find('.phone3').show();
                    }


                }else if(step == 23){
                    if(!ie8)TweenMax.to($enter.find('.center-phone'), 1.3, {'x':0, 'rotation': 0, ease:Power1.easeInOut, clearProps:'all'});
                    TweenMax.to($enter.find('.phone2'), 1, {'autoAlpha': 1});
                    TweenMax.to($enter.find('.phone4'), 1, {'autoAlpha': 0});
                    TweenMax.to($enterSlideInner, 1.3, {'x': -274, ease:Power1.easeInOut});



                }else if(step == 24){
                    //if(!ie8)TweenMax.to($enter.find('.center-phone'), 1.3, {'x':0, 'rotation': 0, ease:Power1.easeInOut, clearProps:'all'});
                    TweenMax.to($enter.find('.phone2'), 1, {'autoAlpha': 0});
                    TweenMax.to($enter.find('.phone4'), 1, {'autoAlpha': 1});

                    TweenMax.to($enterSlideInner, 1.3, {'x': -274*2, ease:Power1.easeInOut});
                }

                BottomBtn.change(step);

                Video.start(step);



                //$boxInnerItem.eq(step-1).css('visibility','visible');


            },

            endWheelStep: function(step){

                //console.log('endWheelStep:'+step);


                if(step == 19){
                    if(!ie8){
                        TweenMax.killDelayedCallsTo($camera);
                        TweenMax.to($camera.find('.item5 .txt'), 1, {'autoAlpha': 0});
                    }
                }else if(step == 20){
                    if(!ie8){
                        TweenMax.to($camera.find('.item5 .txt'), 1, {'autoAlpha': 1, delay:1});
                    }
                }else if(step == 21){
                    if(!ie8){
                        TweenMax.killDelayedCallsTo($camera);
                        TweenMax.to($camera.find('.item5 .txt'), 1, {'autoAlpha': 0});
                        TweenMax.to($enter.find('.center-phone'), 0, {'x':130, 'rotation': -90});



                    }else{
                        $enter.find('.slide').hide();
                        $enter.find('.phone').hide();
                        $enter.find('.phone2').hide();
                        $enter.find('.phone3').show();
                    }
                }else if(step == 22){

                }else if(step == 23){
                    if(ie8){
                        $enter.find('.slide').show();
                        $enter.find('.phone').show();
                        $enter.find('.phone2').show();
                        $enter.find('.phone3').hide();
                    }
                }


                if(step == 15){
                    TweenMax.to($charge.find('.item3 .hand'), 1, {'y': 120, ease:Power1.easeInOut});
                }else if(step == 14){
                    TweenMax.to($charge.find('.item3 .hand'), 0, {'y': 0});
                }else if(step == 16){
                    TweenMax.to($charge.find('.item3 .hand'), 0, {'y': 0});
                }


                if(step == 0){
                    Menu.slideUp();
                }else if(step > 0) {
                    Menu.slideDown();
                }

                //GNB.changeNavi();

                //console.log('endWheelStep:'+step);


                Video.end(step);



                var page = BottomBtn.setPage(step);
                GNB.setPageIdx(page);


            }



        };


        $wrap.scroll(exports.scroll);
        $window.resize(function(){
            exports.resize();
        });


        var $cameraOffImg = $camera.find('.item3 .phone_off');

        $('.hdr_on').click(function(){
            $('.hdr_btn').removeClass('on');
            $(this).addClass('on');
            if(ie8){
                TweenMax.to($cameraOffImg, 1, {'display': 'none'});
            }else{
                TweenMax.to($cameraOffImg, 1, {'autoAlpha': 0});
            }

        });
        $('.hdr_off').click(function(){
            $('.hdr_btn').removeClass('on');
            $(this).addClass('on');

            if(ie8){
                TweenMax.to($cameraOffImg, 1, {'display': 'block'});
            }else{
                TweenMax.to($cameraOffImg, 1, {'autoAlpha': 1});
            }

        });


        //실버 구매 팝업
        $('.silver-banner a').click(function(){
            TweenMax.to('.silver-popup-inner', 0.3, {'autoAlpha': 1});

        });

        $('.silver-popup .xbtn a').click(function(){
            TweenMax.to('.silver-popup-inner', 0.3, {'autoAlpha': 0});
        });

        //핑크골드 예약 팝업
        $('.pinkgold-banner a').click(function(){
            TweenMax.to('.pinkgold-popup-inner', 0.3, {'autoAlpha': 1});

        });

        $('.pinkgold-popup .xbtn a').click(function(){
            TweenMax.to('.pinkgold-popup-inner', 0.3, {'autoAlpha': 0});
        });



        if(ie8){
            $cameraOffImg.hide();


        }


        $('.arrow').click(function(){
            Wheel.movePage(-3);
        });


        Wheel.init(exports);
        GNB.init(exports);
        Menu.init(exports);
        Video.init(exports);
        Intro.init(exports);
        Menu.activeMenu(0);
        exports.resize();





        //side 메뉴 클릭시
        if(getURLParameter('menu') > 0){
            var n = getURLParameter('menu');
            var myTop = $box.eq(n).data('myTop');

            exports.setScrollTop(myTop);
            exports.resize();
            //Wheel.setWheelCount();
        }



    });


});










