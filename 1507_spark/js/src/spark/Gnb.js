
define([
    ""
], function (Circle) {

    var $gnbBtn = $('.gnb-btn');

    $gnbBtn.mouseenter(function(){
        var $on = $(this).find('.gnb-on');
        TweenMax.from($on, 0.4, {autoAlpha:0});
        $on.show();
    });

    $gnbBtn.mouseleave(function(){
        var $on = $(this).find('.gnb-on');
        TweenMax.to($on, 0.2, {autoAlpha:0, clearProps:'all', onComplete:function(){
            $on.hide();
        }});

    });



    var exports = {


    };



    return exports;
});
