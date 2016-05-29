




define([
    'feature/GNB'
], function (GNB) {

    var parents;

    //페이지 추가시 변경 [spen, design 등등]
    var arr = [5, 4, 3, 3, 5, 4, 5];

    var $bottomBtn = $('.bottomBtn');
    var circle = '<div><span class="circle"></span></div>';
    var wid = 20, pageIdx = 0, max;

    TweenMax.to($bottomBtn, 0, {'y': 40, ease:Power1.easeInOut});


    var exports = {




        init: function(p){
            parents = p;
        },

        run: function(idx){

            pageIdx = idx;

            $bottomBtn.html('');

            var str = '';
            max = arr[idx-1]-1;

            for (var i = 0;i<max;i++){
                str+=circle;
            }
            $bottomBtn.append(str).css('marginLeft', (-i*wid)/2);





        },

        setPage: function(step){
            if(step == 0){
                return 0;
            }

            var num = 0, page = 0;
            for (var i = 0;i<arr.length;i++){
                num += arr[i];
                if(step <= num){
                    page = i+1;
                    break;
                }
            }

            return page;

        },

        change: function(step){


            if(pageIdx-1 >= 0){

                var num = 0;
                for (var i = 0;i<pageIdx-1;i++){
                    num += arr[i];
                }
                var n = step-num-2;

                if(n > -1){
                    $bottomBtn.find('.circle').removeClass('on');
                    $bottomBtn.find('.circle').eq(n).addClass('on');
                }

                //console.log(n);

                if(n == 0){
                    TweenMax.to($bottomBtn, 0.4, {'y': 0, ease:Power1.easeInOut});
                }else if(n >= max){
                    TweenMax.to($bottomBtn, 0.4, {'y': 40, ease:Power1.easeInOut});
                }else if(n < 0){
                    TweenMax.to($bottomBtn, 0.4, {'y': 40, ease:Power1.easeInOut});
                }


            }


        }




    };


    return exports;


});













