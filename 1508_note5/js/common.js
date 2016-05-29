$(document).ready(function(){

});

if( location.href.indexOf("samsung.com") != -1 ){
	document.domain = "samsung.com";
}


(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

ga('create', 'UA-66498584-1', 'auto');
ga('send', 'pageview');



/* 옴니츄어 및 구글태깅 */
function eventTrack(omni,google){
	if(omni != ''){
		adobeActionTrack('o',omni);
	}

	if(google != ''){
		ga('send', 'event', google, 'click');
	}
}


function frameResize(){
	parent.window.frameResize(parent.document.getElementById("iframecontents"));

}




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

function introLoaded(obj, objParent){

	fit.defaults.watch = true;
	fit.defaults.cover = true;

	//console.log(obj);

	fit( obj, objParent, fit.cssPosition);

}




$(function(){
	$('a').click(function(){
		if($(this).attr('href') == '#'){
			return false;
		}
	});








});