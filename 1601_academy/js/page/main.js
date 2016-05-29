

var main = (function(){



    var $videoBtn = $('.video_btn');
    var $current = $videoBtn.eq(0);
    var $iframe = $('.video_area iframe');
    var idx = -1;

    var videoArr = [
        'PyGL60gFWEg',
        'uEi4fftqjYc',
        'PTW09skRKFE',
        'v22Un2VRVGI',
        'vdsofmpOIXs'
    ];



    TweenMax.to($videoBtn.prev(), 0, {display:'block', opacity:0});


    var videoClickListener = function(){


        if($current) {
            $current.parent().removeClass('active');
            TweenMax.to($current.prev(), 0.4, {autoAlpha:0});
        }
        $(this).parent().addClass('active');
        $current = $(this);
        TweenMax.to($(this).prev(), 0.4, {autoAlpha:1});

        idx = $(this).parent().index();

        changeVideo(idx);


    };

    var changeVideo = function(idx){


        $iframe.attr('src', 'https://www.youtube.com/embed/' + videoArr[idx] + '?wmode=opaque&rel=0');
    };

    $videoBtn.bind('click', videoClickListener);
    videoClickListener.call($current);





    var $itemWrap = $('.item_wrap');
    $itemWrap.mouseenter(function(){
        if($(this).find('.go_btn').length > 0) $(this).find('.go_btn').get(0).active();
    });

    $itemWrap.mouseleave(function(){
        if($(this).find('.go_btn').length > 0) $(this).find('.go_btn').get(0).deactive();
    });
    $itemWrap.click(function(){
        if($(this).find('.go_btn').length > 0){
            var btn = $(this).find('.go_btn').get(0);
            var url = btn.href;
            if(btn.target == "_blank"){
                window.open(url);
            }else{
                window.location = url;
            }
            return false;
        }

    });






    return {

    }

}());