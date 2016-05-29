
function getURLParameter(name) {
    //if(getURLParameter('p') == 'event')
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
}

function gameFinished(score){
    if(parent.window.gameFinish){
        parent.window.gameFinish(score);
        console.log("gameFinished"+score);
    }else{
        alert('parent.window.gameFinish 호출: ' + score);
    }
}