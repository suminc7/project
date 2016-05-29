
define([
    ""
], function () {


    var stage, stageW, blockW, blockH, blockCount, typing, step1Callback, spacebarText, step1;

    return {

        init: function(callback){


            stage = venezia.stage;
            stageW = venezia.stageW;
            blockW = 32;
            blockH = 16;
            blockCount = 12;

            step1Callback = callback;

            this.initInput();
            this.initObject();
        },

        startGame: function(){

            typing.visible = true;
            venezia.$inputTyping.show().focus();
            //spacebarText.visible = false;
            step1.visible = false;
            step1Callback();

        },

        initInput: function(){
            venezia.$inputTyping = $('#typing');
            venezia.$inputTyping.focus();

            venezia.$inputTyping.bind('keyup', function(e){
                switch(e.which) {
                    case 13: // return
                        if(this.value != ''){
                            venezia.WordController.wordCheck(this.value);
                            this.value = '';
                        }
                        break;
                    default: return;
                }
                e.preventDefault();
            });
            venezia.$inputTyping.hide();

        },

        initObject: function(){

            var header = new createjs.Sprite(venezia.spriteSheet, 'header');
            stage.addChild(header);

            var footer = new createjs.Sprite(venezia.spriteSheet, 'footer');
            footer.y = venezia.stageH - venezia.footerH;
            stage.addChild(footer);


            step1 = new createjs.Sprite(venezia.spriteSheet, 'step1');
            step1.x = venezia.sceneW/2;
            step1.y = venezia.sceneH/2;
            stage.addChild(step1);






            //
            //$(document).bind('keyup', function(e){
            //    switch(e.which) {
            //        case 32: // space
            //            if(venezia.isStart){
            //
            //                typing.visible = true;
            //                venezia.$inputTyping.show().focus();
            //                spacebarText.visible = false;
            //                step1.visible = false;
            //                step1Callback();
            //                $(document).unbind('keyup');
            //            }
            //            break;
            //        default: return;
            //    }
            //    e.preventDefault();
            //
            //
            //});


            var block;
            for (var i=0;i<12;i++){
                block = new createjs.Sprite(venezia.spriteSheet, 'block1');
                block.x = venezia.stageW / 2 - (blockW*3/2) + 32 * (i % 3);
                block.y = venezia.stageH - 16 - (blockH*4) + 16 * Math.floor(i/3);
                block.name = "block"+(i+1);
                stage.addChild(block);

            }

            typing = new createjs.Sprite(venezia.spriteSheet, 'typingArea');
            typing.x = venezia.stageW/2 - 112/2;
            typing.y = venezia.stageH - blockH - (blockH*4) - 48;
            stage.addChild(typing);
            typing.visible = false;

            //spacebarText = new createjs.Text("사이띄개를 누르세요!", "16px Jeju Myeongjo", "#000");
            //spacebarText.x = 5;
            //spacebarText.y = venezia.sceneH - 16;
            //spacebarText.textAlign = "left";
            //spacebarText.letterSpacing = 5;
            //stage.addChild(spacebarText);


            var title1 = "한  메  타  자  교  사";
            var title2 = "한메타자교사";
            if(venezia.country == "en"){
                title1 = "V  E  N  E  Z  I  A";
                title2 = "VENEZIA";
            }

            var text = new createjs.Text(title1, "16px Jeju Myeongjo", "#fff");
            text.x = venezia.sceneW/2;
            text.y = 4;
            text.textAlign = "center";
            //text.scaleY = 0.95;
            text.letterSpacing = 5;
            //text.outline = 0.1;
            //text.textBaseline = "alphabetic";
            stage.addChild(text);

            var text = new createjs.Text(title2, "16px Jeju Myeongjo", "#000");
            text.x = venezia.sceneW-5;
            text.y = venezia.sceneH-16;
            text.textAlign = "right";
            stage.addChild(text);
        },

        //blockCount 12~1
        removeBlock: function(){
            if(blockCount > 0){
                var block = stage.getChildByName("block" + blockCount);
                block.gotoAndStop('block2');
                blockCount--;

                //block이 모두 깨지면
                if(blockCount == 0){
                    venezia.WordController.allStop();
                    venezia.$inputTyping.hide();

                    var count = 0;

                    var func = function(){

                        //typing 아래로 다운
                        typing.y = typing.y + 16;

                        if(count == 0){
                            venezia.SoundController.end();
                        }

                        //위에서부터 3개씩 block 삭제
                        for (var i=0;i<3;i++){
                            var n = (i+1)+(count*3);
                            var block = stage.getChildByName("block"+n);
                            block.visible = false;
                        }


                        if(count == 3){
                            clearInterval(interval);
                            gameFinished(venezia.score);
                        }
                        count++;
                    }

                    var interval = setInterval(func, 800);
                    func();
                }



            }
        }


    };
});
