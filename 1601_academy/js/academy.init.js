
academy.init = (function(){


    responsive.addChangedType(function(type, size){
        academy.frameResize();
    });

    var youtube = $("iframe[data-ratio]");
    responsive.addResizer(function(type, size){
        youtube.each(function(){
            var $self = $(this);
            var width = $self.parent().width();
            $self.attr('width', width).attr('height', Math.floor(width/16*9));
        });
        academy.frameResize();
    });
    responsive.resize();


    return {

    }

}());


academy.gnb = (function(){



    var $currentGnb = null;
    var $btn = $('.gnb_item > a');
    var $html = $('html');
    var $gnb = $('.gnb');

    $gnb.bind('mouseleave', function(){
        navDeactive.call($currentGnb);
        $currentGnb = null;
    });

    var navActive = function(){
        if(!$html.hasClass('t1')){
            var $self = $(this);
            var $subWrap = $self.next('.sub_wrap');
            //console.log('active');
            TweenMax.killTweensOf($subWrap);
            TweenMax.set($subWrap, {autoAlpha:0, display:'block'});
            TweenMax.to($subWrap, 0.3, {autoAlpha:1});
        }
    };

    var navDeactive = function(){
        if(!$html.hasClass('t1')) {
            var $subWrap = $(this).next('.sub_wrap');
            //console.log('deactive');
            TweenMax.to($subWrap, 0.3, {autoAlpha: 0, clearProps: 'all'});
        }
    };

    function navBtnListener(e){
        var $self = $(this);

        if($currentGnb){
            navDeactive.call($currentGnb);
        }else{
        }
            navActive.call($self);
            $currentGnb = $self;

        //if($subWrap.length > 0) $subWrap.addClass('active');
    }


    //$btn.bind('touchend', navBtnListener);
    $btn.bind('mouseenter', navBtnListener);



    var mobile = (function(){

        /*
         mobile
         */

        var isActive = false;
        var $navBtn = $('.navContainer');


        var mobileNavActive = function(){
            TweenMax.to($gnb, 0.3, {autoAlpha:1});
            $navBtn.addClass('active');
            isActive = true;
        };

        var mobileNavDeactive = function(){
            TweenMax.to($gnb, 0.3, {autoAlpha:0, clearProps:'all'});
            $navBtn.removeClass('active');
            isActive = false;
        };

        var mobileNavListener = function(event){
            if(isActive){
                mobileNavDeactive();
            }else{
                mobileNavActive();
            }

            event.preventDefault();
        };

        //$navBtn.bind('touchend', mobileNavListener);
        $navBtn.bind('click', mobileNavListener);


        return {
            active: function(b){
                //mobileNavActive($navBtn.eq(b));
                $navBtn.eq(b).addClass('active');
            }
        }



    }());


    return {
        active:function(a, b){

            $btn.eq(a).addClass('active');
            $btn.eq(a).next('.sub_wrap').find('a').eq(b).addClass('active');

        }

    }

}());









$('.go_btn').each(function(){
    var $self = $(this);
    $self.append('<span class="btn_back"></span><span class="btn_wrap"></span><span class="btn_border"></span>');

    var $btnBack = $self.find('.btn_back');

    this.active = function(){
        $self.addClass('active');
        TweenMax.to($btnBack, 0.3, {width:'100%'});
    };
    this.deactive = function(){
        $self.removeClass('active');
        TweenMax.to($btnBack, 0.3, {width:0});
    };


    //$self.mouseenter(function(){
    //    this.active();
    //});
    //$self.mouseleave(function(){
    //    this.deactive();
    //});
});
