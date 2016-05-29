if( location.href.indexOf("samsung.com") != -1 ){
    document.domain = "samsung.com";
}

function setHeaderTop(){
    parent.window.scrollTo(0, parent.$('#content').offset().top);
}

window.onload = function(){
    setTimeout(setHeaderTop, 100);
};


/* 옴니츄어 및 구글태깅 */
function eventTrack(omni,google){
    if(omni != ''){
        adobeActionTrack('o',omni);
    }

    if(google != ''){
        ga('send', 'event', google, 'click');
    }
}


function getFilename(str) {
    return str.split('\\').pop().split('/').pop();
}



var academy = (function(window, document){


    $(document).ready(function(){

    });



    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-71964425-1', 'auto');
    ga('send', 'pageview');













    //if($.browser.msie && $.browser.version < 9){
    //    window.ie8 = true;
    //}else{
    //    window.ie8 = false;
    //}


    //function thisMovie(movieName) {
    //    if (navigator.appName.indexOf("Microsoft") != -1) {
    //        return window[movieName]
    //    }
    //    else {
    //        return document[movieName]
    //    }
    //}



    if( window.console == undefined ) { window.console = {log : function(){} }; }



    $(function(){
        $('a').click(function(){
            if($(this).attr('href') == '#'){
                return false;
            }
        });

    });



    return {
        frameResize: function(){
            if(parent.window.frameResize)parent.window.frameResize(parent.document.getElementById("iframecontents"));
        }
    }


}(window, document));




function RadioSelect($obj){

    var $current = null;
    var $first = $obj.filter(":checked");

    this.click = function(){
        if($current) $current.removeClass('on');
        $current = $(this).parents('.radio_wrap');
        $current.addClass('on');
    };

    this.reset = function(){
        $first.removeClass('on');
        $obj.prop('checked', false);
        //if($first.length > 0){
        $first.prop('checked', true);
        this.click.call($first);

        //}

    };

    this.radio = $obj;


    $obj.bind('click', this.click);
    this.click.call($first);

}



function getURLParameter(name) {
    //if(getURLParameter('p') == 'event')
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
}