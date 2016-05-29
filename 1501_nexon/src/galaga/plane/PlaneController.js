
define([
    "galaga/plane/Plane",
    "galaga/plane/Missile"
], function () {

    var stage, monsterArr, sceneW, container;


    return {

        init: function(){
            stage = galaga.stage;
            monsterArr = galaga.monsterArr;
            sceneW = galaga.sceneW;

            container = new createjs.Container();
            container.name = "planeContainer";
            stage.addChild(container);


            this.createPlane();
        },


        createPlane: function(){

            var plane = new createjs.Plane();
            plane.x = sceneW / 2;
            plane.y = galaga.sceneH - 40;
            container.addChild(plane);
            galaga.plane = plane;


        }


    };
});
