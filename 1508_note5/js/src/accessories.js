var acc = (function(){
    var agent = navigator.userAgent;
    var $accBtnNext = $(".btn_next");
    var $accBtnPrev = $(".btn_prev");
    var $dotsList =$('.slick-dots li');
    var $productColorBtn =$('.product_color li a');
    var isMove = false;

    var exports = {

        init : function(){
            $(document).ready(function() {

                $(document).on('click', '.product_color li a', function(e){

                    e.preventDefault();
                    var $self = $(this);
                    var color = $self.attr("data-img");
                    var cls = $self.parents('.product_color').attr("data-cls");
                    $('.slick-slide').find('.'+cls+' >img').attr("src",imgServerDomain+"/images/acc/"+color+".png");
/*
                    setTimeout(function(){

                    $self.parents('.slick-slide').find('.acc_images >img').attr("src",imgServerDomain+"/images/acc/"+color+".png");
                    },210);
                    TweenMax.to(   $self.parents('.slick-slide').find('.acc_images >img'), 0.2, {alpha:0,ease:Power2.easeOut,onComplete:function(){
                        TweenMax.to(   $self.parents('.slick-slide').find('.acc_images >img'), 0.3, {delay:0.05,alpha:1});
                    }});
*/
                    $self.parents('.product_color').find('a').removeClass('active');
                    $self.addClass('active');

                });
                $dotsList.find('a').on('click', function(e){


                    if(!isMove) {
                        $dotsList.removeClass('slick-active');
                        $(this).parent().addClass('slick-active');
                    }

                    $('.center').slick('slickGoTo', $(this).attr('data-idx'));
                    isMove=true;
                });

                if(agent.indexOf("MSIE 7.0") > 0 || agent.indexOf("MSIE 8.0")> 0 || agent.indexOf("MSIE 9.0") > 0){

                    $('.center').slick({
                        centerMode: true,
                        touchMove:false,
                        prevArrow:$('.btn_prev'),
                        nextArrow:$('.btn_next'),
                        slidesToShow: 1,
                        speed: 800
                    }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {

                        frameResize();
                        $dotsList.eq(currentSlide).removeClass('slick-active');
                    }).on('afterChange', function (event, slick, currentSlide, nextSlide) {
                        isMove = false;
                        $dotsList.eq(currentSlide).addClass('slick-active');
                    });


                }else {

                    $('.center').slick({
                        centerMode: true,
                        slidesToShow: 3,
                        touchMove: false,
                        variableWidth: true,
                        prevArrow: $('.btn_prev'),
                        nextArrow: $('.btn_next'),
                        cssEase: 'ease-in-out',
                        speed: 800,
                        responsive: [
                            {
                                breakpoint: 1024,
                                settings: {
                                    centerMode: true,
                                    variableWidth: false,
                                    slidesToShow: 1
                                }
                            },
                            {
                                breakpoint: 767,
                                settings: {
                                    centerMode: true,
                                    variableWidth: false,
                                    slidesToShow: 1
                                }
                            }
                        ]
                    }).on('beforeChange', function (event, slick, currentSlide, nextSlide) {

                        frameResize();
                        $dotsList.eq(currentSlide).removeClass('slick-active');
                    }).on('afterChange', function (event, slick, currentSlide, nextSlide) {
                        isMove = false;
                        $dotsList.eq(currentSlide).addClass('slick-active');
                    });


                }

                frameResize();
                $(parent.window).resize(function() {
                    frameResize();
                });
                $(window).resize(function(){
                    frameResize();
                    /*
                    var $loadWidth = $(this).width();
                    console.log($loadWidth);
                    if( $loadWidth <= 500 ){

                        TweenMax.to($accBtnNext, 1, {right: "10%",top:"190px", ease: Power1.easeInOut});
                        TweenMax.to($accBtnPrev, 1, {left: "10%",top:"190px", ease: Power1.easeInOut});

                    }else if( 500 < $loadWidth && $loadWidth <= 1200){

                        TweenMax.to($accBtnNext, 1, {right: "10%",top:"310px", ease: Power1.easeInOut});
                        TweenMax.to($accBtnPrev, 1, {left: "10%",top:"310px", ease: Power1.easeInOut});

                    }else if (1200 < $loadWidth &&  $loadWidth <= 1600) {

                        //console.log("sss");
                        TweenMax.to($accBtnNext, 1, {right: "18%", ease: Power1.easeInOut});
                        TweenMax.to($accBtnPrev, 1, {left: "18%", ease: Power1.easeInOut});

                    }else{

                        TweenMax.to($accBtnNext, 1, {right: "23%", ease: Power1.easeInOut});
                        TweenMax.to($accBtnPrev, 1, {left: "23%", ease: Power1.easeInOut});
                    }
                     */
                });
               // $(window).trigger("resize");

            });
        },
        reSize : function(){

            var docHeight = $("#wrap").height();
            try{
                parent.document.getElementById("iframecontents").style.height = docHeight + "px";
                $("#iframecontents", parent.document).height( docHeight ) ;
                $("#iframecontents", parent.document).parent().height( docHeight ) ;
            }catch(e){}
        }
    }
    return exports;
})();

acc.init();


require([
    'feature/Menu'

], function (Menu) {
    Menu.activeMenu(6);

});