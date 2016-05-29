
if($.browser.msie && $.browser.version < 9){
    window.ie8 = true;
}else{
    window.ie8 = false;
}


function thisMovie(movieName) {
    if (navigator.appName.indexOf("Microsoft") != -1) {
        return window[movieName]
    }
    else {
        return document[movieName]
    }
}

function getURLParameter(name) {
    //if(getURLParameter('p') == 'event')
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
}

if( window.console == undefined ) { console = {log : function(){} }; }


$(function(){
    $('a').click(function(){
        if($(this).attr('href') == '#'){
            return false;
        }
    });
});

var tracking = function(track){
    ga('send', 'event', track, 'click');
};

(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-55532640-11', 'auto');
ga('send', 'pageview');
