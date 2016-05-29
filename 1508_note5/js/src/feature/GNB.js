




define([
    'feature/controller/Wheel',
    'feature/Menu',
    'feature/BottomBtn'
], function (Wheel, Menu, BottomBtn) {

    var parents;
    var $gnb = $('.navi .gnb');
    var $naviBtn = $('.navi .gnb .gnb-item');
    var $gra = $('.navi .gnb .gra');
    var pageIdx = 0;
    var $box = $('.box');

    var $myPageInner, $myDesc, $myPage;
    var $nextPageInner, $nextDesc, $nextPage;
    var posOffset = 13;
    var currentIdx = -1;
    var posArr = [-13+posOffset, 32+posOffset, 105+posOffset, 227+posOffset, 325+posOffset, 407+posOffset, 543+posOffset];
    var firstTracking = false;

    $gnb.mouseleave(function(){
        //console.log('currentIdx:'+currentIdx);
        //if(pageIdx-1 > -1){
        //if(!exports.clicked){
            exports.onNavi(pageIdx-1);
        //}
        //}
    });
    $naviBtn.mouseenter(function(){

        if(pageIdx > 0){
            exports.offNavi(pageIdx-1);
        }


        var $self = $(this);
        var idx = $self.index();
        $self.addClass('on');
        exports.onNavi(idx);

    });
    $naviBtn.mouseleave(function(){

        var $self = $(this);
        var idx = $(this).index();
        $self.removeClass('on');
        exports.offNavi(idx);
    });


    $naviBtn.click(function(){

        if(Wheel.isWheel){
            return;
        }

        if(exports.clicked){
            return;
        }

        exports.clicked = true;

        var idx = $(this).index()+1;
        exports.movePage(idx);

    });

    function scrollStart(){
        Wheel.isWheel = true;
        parents.startWheelStep(Wheel.getWheelCount());
    }

    function scrollComplete(myTop){


        TweenMax.set($myPageInner, {'x': 0});
        if(!ie8)TweenMax.set($myDesc, {'x': 0, 'y': 0});


        Wheel.isWheel = false;
        exports.clicked = false;
        parents.setScrollTop(myTop);

        $myPage.css('display', 'none');


    }



    var exports = {

        clicked: false,


        movePage: function(idx){
            var winHei = parents.winHei;



            $myPage = $box.eq(pageIdx);
            $myPageInner = $myPage.find('.inner');
            $myDesc = $myPage.find('.desc');




            $nextPage = $box.eq(idx);
            $nextPageInner = $nextPage.find('.inner');
            $nextDesc = $nextPage.find('.desc');
            var myTop = $nextPage.data('myTop');

            currentIdx = idx;

            //console.log('pageIdx:'+pageIdx);
            //console.log('idx:'+idx);

            if(!ie8){
                $nextPage.find('.content').removeClass('ie8');
            }


            if(pageIdx == idx){
                exports.clicked = false;
                return false;
            }else if(pageIdx < idx){
                //next
                TweenMax.set($nextPageInner, {'x': 0});


                if(!ie8){
                    TweenMax.set($nextDesc, {'x': 0, 'y': -500});
                    TweenMax.to($nextDesc, 1.3, {'x': 0, 'y': 0, ease:Power1.easeInOut});
                    TweenMax.to($myDesc, 1.3, {'y': 500, ease:Power1.easeInOut});
                }


                TweenMax.to($myPage, 1.3, {'top': -winHei*1.5, ease:Power1.easeInOut, display:'block'});
                TweenMax.to($nextPage, 0, {'top': winHei*1.5, display:'block'});
                TweenMax.to($nextPage, 1.3, {'top': 0, ease:Power1.easeInOut, onComplete:scrollComplete, onCompleteParams:[myTop]});
                scrollStart();
            }else if(pageIdx > idx){

                //prev
                TweenMax.set($nextPageInner, {'x': 0});

                if(!ie8){
                    TweenMax.set($nextDesc, {'x': 0, 'y': 500});
                    TweenMax.to($nextDesc, 1.3, {'x': 0, 'y': 0, ease:Power1.easeInOut});
                    TweenMax.to($myDesc, 1.3, {'y': -500, ease:Power1.easeInOut});
                }

                TweenMax.to($myPage, 1.3, {'top': winHei*1.5, ease:Power1.easeInOut, display:'block'});
                TweenMax.to($nextPage, 0, {'top': -winHei*1.5, display:'block'});
                TweenMax.to($nextPage, 1.3, {'top': 0, ease:Power1.easeInOut, onComplete:scrollComplete, onCompleteParams:[myTop]});
                scrollStart();

            }


            exports.setPageIdx(idx);
        },

        getPageIdx: function(){
            return pageIdx;
        },

        setPageIdx: function(idx){


            if(pageIdx != idx){
                if(pageIdx > 0){
                    if(idx > 0)exports.offNavi(pageIdx-1);
                }
                if(idx > 0)this.onNavi(idx-1);
                pageIdx = idx;
                console.log('pageIdx-------------:'+pageIdx);
                BottomBtn.run(pageIdx);
                Menu.activeSubMenu(0, pageIdx-1);



                var track = "";
                var omniture = "";
                if(pageIdx == 1){
                    track = "spen_gate";
                    omniture = "features:spen";
                }else if(pageIdx == 2){
                    track = "design_gate";
                    omniture = "features:design";
                }else if(pageIdx == 3){
                    track = "pay_gate";
                    omniture = "features:samsung pay";
                }else if(pageIdx == 4){
                    track = "charging_gate";
                    omniture = "features:charging";
                }else if(pageIdx == 5){
                    track = "camera_gate";
                    omniture = "features:camera";
                }else if(pageIdx == 6){
                    track = "entertainment_gate";
                    omniture = "features:entertainment";
                }else if(pageIdx == 7){
                    track = "performance_gate";
                    omniture = "features:performance";
                }

                //console.log(firstTracking);
                if(firstTracking){
                    eventTrack(omniture,track);

                }
                firstTracking = true;



            }

        },



        init: function(p){
            parents = p;


        },

        onNavi: function(idx){
            if(idx > -1){

                var $btn = $naviBtn.eq(idx);
                var wid = $btn.width();
                TweenMax.to($gra, 0.5, {'left': posArr[idx], width: wid+27,  ease:Power1.easeInOut});
                $btn.find('span').addClass('active');
                //TweenMax.to($btn.find('span'), 0.5, {'background-position':'0px '+-12+'px', ease:Power1.easeInOut});
            }
        },

        offNavi: function(idx){
            if(idx > -1){
                var $btn = $naviBtn.eq(idx);
                $btn.find('span').removeClass('active');
                //TweenMax.to($btn.find('span'), 0.5, {'background-position':'0px 0px', ease:Power1.easeInOut});
            }
        }


    };

    //exports.onNavi(pageIdx);
    exports.setPageIdx(pageIdx);

    return exports;


});













