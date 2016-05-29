

var responsive = (function(window, document){

    function isIE () {
        var myNav = navigator.userAgent.toLowerCase();
        return (myNav.indexOf('msie') != -1) ? parseInt(myNav.split('msie')[1]) : false;
    }

    var ieVersion = isIE();


    var $html = $('html'),  resizeArr = [], changedTypeArr = [];
    var type = "", wtype = "";
    var typeBefore = "", wtypeBefore = "";

    if(ieVersion > 0 && ieVersion < 9){
        $html.css('min-width', 768);
    }


    var resize = function(){
        var width = document.documentElement.offsetWidth, t = 0, w = 0;


        if(width > 1440){
            t = 3;
            w = 6;
        }else if(width > 1024){
            t = 3;
            w = 5;
        }else if(width > 767){
            t = 2;
            w = 4;
        }else if(width > 680){
            t = 2;
            w = 3;
        }else if(width > 360){
            t = 1;
            w = 2;
        }else if(361 > width){
            t = 1;
            w = 1;
        }

        if(ieVersion > 0 && ieVersion < 9){
            t = 3;
        }


        type = "t"+t;
        wtype = 'w' + w;
        if(wtype != wtypeBefore){
            $html.removeClass(wtypeBefore).addClass(wtype);
        }

        if(type != typeBefore){
            $html.removeClass(typeBefore);
            $html.addClass(type);

            var len1 = changedTypeArr.length;
            for(var i = 0;i<len1;i++){
                changedTypeArr[i].call(null, type, width);
            }
        }
        typeBefore = type;
        wtypeBefore = wtype;


        var len2 = resizeArr.length;
        for(var j = 0;j<len2;j++){
            resizeArr[j].call(null, type, width);
        }


    };


    $(window).resize(resize);
    resize();

    return {
        resize: resize,
        getResizeType: function(){
            return type;
        },
        addChangedType: function(func){
            changedTypeArr.push(func);
        },
        addResizer: function(func){
            resizeArr.push(func);
        },
        getIeVersion: function(){
            return ieVersion;
        }
    }

}(window, document));
