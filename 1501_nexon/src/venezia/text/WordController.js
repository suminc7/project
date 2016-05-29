
define([
    ""
], function () {





    var wordAllArr, wordArr, stage, stageW, containerArr, removeArr, isStop, self;

    var maxWordLen = 20;
    var currentWordLen = 0;

    return {

        init: function(arr){
            wordAllArr = arr;
            containerArr = [];
            wordArr = [];
            removeArr = [];

            isStop = false;
            self = this;


            stage = venezia.stage;
            stageW = venezia.stageW;

            this.createWords();
            this.wordsTimeInterval();

            this.controllerUpdate();
        },

        start: function(){

        },

        createWords: function(){


            //var word = new createjs.Word();
            //word.appendText(arr[0]);

            //console.log(wordAllArr);

            var len = wordAllArr.length;

            for (var i = 0;i < maxWordLen;i++){
                var txt = wordAllArr[i];
                var t = new createjs.Text(txt, "bold 16px Jeju Myeongjo", "#000");
                t.width = txt.length*16;
                t.textAlign = 'left';
                //console.log(t.text, txt.length);

                var container = new createjs.Container();
                container.idx = i;
                container.addChild(t);
                container.x = Math.floor( 10 + Math.random() * (stageW - 20 - t.width) );
                //console.log(offsetX*15);
                //console.log(container.x);
                container.y = 15;
                container.txtWidth = t.width;
                containerArr.push(container);
                //console.log(container);
            }



            //stage.addChild(container);


        },

        wordCheck: function(myWord){

            var len = wordArr.length;
            var word;
            var self = this;
                //console.log(myWord);


            for(var i=0;i < len;i++){
                word = wordArr[i];
                if(word){
                    //console.log(word);
                    var txt = word.children[0].text;

                    // 화면에 있는 단어와 동일하면 stage 에서 제거
                    if(myWord == txt){

                        venezia.score = venezia.score + 100;
                        //self.appendRemoveContainer(word, word.idx);
                        self.removeStage(word, word.idx);
                        venezia.SoundController.hit();


                        currentWordLen = currentWordLen + 1;
                        //console.log(currentWordLen);
                        if(currentWordLen == maxWordLen){
                            gameFinished(venezia.score);
                        }

                        break;
                    }
                }


            }
        },

        wordsTimeInterval: function(){

            var count = 0;
            var cn = 2; // 2일때 텍스트 생성
            var self = this;

            var wInterval = setInterval(function(){

                if(isStop){
                    clearInterval(wInterval);
                    return;
                }

                var len = wordArr.length;
                var i;
                var sortWordArr = [];
                for(i=0;i < len;i++){

                    word = wordArr[i];

                    //if(word){
                    //    sortWordArr.push(word);
                    //}

                }
                //wordArr = sortWordArr;


                //cn = 2 일때 화면에 단어 한개씩 추가
                if(cn == 2){
                    // stage에 container 붙이기

                    if(count < maxWordLen){

                        if(Math.random() > 0.10){


                            var word = containerArr[count];
                            wordArr.push(word);
                            stage.addChild(word);
                            count++;
                        }
                        //console.log(count);
                    }

                    cn = -1;
                }
                cn++;


                len = wordArr.length;

                var wordNullCount = 0;//몇개만 틀렸을시 셀수 있는 카운트

                for(i=0;i < len;i++){

                    word = wordArr[i];

                    if(wordArr[i] !== null){
                        wordNullCount++;
                    }


                    if(word){
                        word.y += 15; // container를 아래로 다운

                        //입력상자에 부딛힐때
                        if(word.y > 325){
                            // x 축이 상자와 닿으면
                            if(264 < word.x + word.txtWidth && word.x < 376){
                                //console.log('---상자');
                                self.appendRemoveContainer(word, i);
                            }
                        }

                        //파도에 부딛힐때
                        if(word.y > 420){
                            //console.log('---파도');
                            self.appendRemoveContainer(word, i);
                        }
                    }

                }

                if(wordNullCount == 0){
                    self.allStop();
                    gameFinished(venezia.score);
                }

                console.log(wordNullCount);

                self.removeWordArr();
                //console.log(wordArr.length);
                //console.log(wordArr.length);



            }, 500);
        },

        //removeArr에 push후에 removeWordArr 함수에서 모두 삭제
        appendRemoveContainer: function(word, i){

            removeArr.push({word:word, idx:i});
            venezia.SoundController.block();
        },

        removeWordArr: function(){
            var len = removeArr.length;
            for(var i=0;i < len;i++) {
                var word = removeArr[i].word;
                var idx = removeArr[i].idx;
                this.removeStage(word, idx);
                venezia.UIController.removeBlock();
            }
            removeArr = [];

        },

        removeStage: function(word, idx){
            stage.removeChild(word);
            wordArr[idx] = null;
            //console.log(wordArr);
            //wordArr.splice(idx, 1);
            //console.log(wordArr.length);

        },

        allStop: function(){
            isStop = true;
        },

        update : function(){



        },

        controllerUpdate: function(){

            createjs.Ticker.timingMode = createjs.Ticker.RAF;
            createjs.Ticker.addEventListener("tick", this.update);
        }
    };
});
