




define([
    ''
], function () {

    var parents;
    var $nav = $('.navi'), $navInner = $('.navi .navi-inner'), $navContents = $('.navi .navContents'), $menu = $navContents.find('.menu'), $navContainer = $('.navi .navContents .navContainer');
    var $menuList = $('.menu-list > li');
    var $menuListBtn = $('.menu-list > li > a');
    var $submenuList = $nav.find('.submenu-list');

    var isClick = false;
    var wid = 330, hei = 1000;



    if($('body.features').length < 1){
        $navContents.removeClass('white');
        //$nav.addClass('features');
    }

    $submenuList.slideUp(0);
    //$submenuList.eq(0).slideDown(0);

    $menuListBtn.click(function(){
        var idx = $(this).parent().index();
        chageSideMenu(idx);
    });


    function chageSideMenu(idx){
        $submenuList.slideUp();


        $submenuList.eq(idx).slideDown();

        $menuListBtn.removeClass('active');
        $menuListBtn.eq(idx).addClass('active');
    }



    $navContainer.click(function(){
        if(isClick){
            exports.offMenu();
        }else{
            exports.onMenu();
        }
    });

    var arc = {r: 0, x:wid*0.5, y:-100};



    var $canvas = $('#menuCanvas');
    var canvas = $canvas[0];

    if(!(navigator.userAgent.indexOf('Mobile') > -1) && !ie8){
        var context = canvas.getContext('2d');


        var runArc = function(){
            context.clearRect(0, 0, wid, hei);
            context.beginPath();
            context.arc(arc.x, arc.y, arc.r, 0, 2 * Math.PI, true);
            context.fillStyle = 'rgba(19,37,65,0.9)';
            context.fill();

        };
    }else{
        $('#menuCanvas').addClass('tablet');
    }





    var exports = {




        init: function(p){
            parents = p;


        },

        activeMenu: function(a, b){
            $menuList.eq(a).children('.menu-item').addClass('active');
            $menuList.eq(a).find('.submenu-list').slideDown(0);

            if(b > -1){
                this.activeSubMenu(a, b);
            }
        },

        activeSubMenu: function(a, b){
            var $btn = $menuList.eq(a).find('.submenu-list li a');
            $btn.removeClass('active');
            $btn.eq(b).addClass('active');
        },

        onMenu: function(){

            isClick = true;
            $navContents.addClass('on');
            $menu.css('display', 'block');

            TweenMax.to(arc, 0.7, {'r': 1100, ease:Power2.easeInOut, onUpdate:runArc});

            TweenMax.set($menuList, {'x':20, 'autoAlpha':0});
            for (var i=0;i<$menuList.length;i++){
                TweenMax.to($menuList.eq(i), 0.5, {'x':0, 'autoAlpha':1, delay:0.3+0.05*i});
            }
        },

        offMenu: function(){

            isClick = false;
            $navContents.removeClass('on');
            TweenMax.to(arc, 0.7, {'r': 0, ease:Power2.easeInOut, onUpdate:runArc, onComplete:function(){
                $menu.css('display', 'none');
            }});

            TweenMax.to($menuList, 0.2, {'autoAlpha':0});
        },

        slideUp: function(){
            TweenMax.to($navInner, 0.3, {'marginTop':-55, ease:Power1.easeInOut});
            $navContents.addClass('white');

        },

        slideDown: function(){
            TweenMax.to($navInner, 0.3, {'marginTop':0, ease:Power1.easeInOut});
            $navContents.removeClass('white');

        }



    };




    return exports;


});













