

var academyCustomURL = 'http://images.s-academy.co.kr';
academy.gnb.active(2,3);




var event2 = (function(){


    $("input[type=number]").on('keydown keyup',function(){
        var $that = $(this),
            maxlength = $that.attr('maxlength');
        if($.isNumeric(maxlength)){
            $that.val($that.val().substr(0, maxlength));
        };
    });

    $('html,body').height('auto');

    var $radioProduct = $('input[name=product]');
    var $radioTo = $('input[name=to]');
    var $eventPopup = $('.event_popup');
    var $step1 = $('.step1');
    var $step2 = $('.step2');
    var $step3 = $('.step3');
    var $step4 = $('.step4');
    var $make = $('.make');
    var $complete = $('.complete');
    var $btnSave = null;


    $step1.show();
    $step2.hide();
    $step3.hide();
    $step4.hide();
    $make.hide();
    $complete.hide();



    var radioSelect3 = new RadioSelect($radioProduct);
    var radioSelect4 = new RadioSelect($radioTo);

    var thumbnailName = null;
    var selectedImg = (Math.floor(Math.random() * 3) + 1);
    var customMessage = "";


    function getRadioProduct(){
        return $($radioProduct).filter(":checked").val();
    }

    function getRadioTo(){
        return $($radioTo).filter(":checked").val();
    }

    function getThumbnailName(){
        if(!thumbnailName){
            thumbnailName = getRadioProduct();
        }
        return thumbnailName;
    }

    function uploadComplete(){
        $('.btn_upload').removeClass('loading');
        isSubmit = false;
    }


    function frameResize(){

        setTimeout(function(){
            academy.frameResize();
        },50);
    }

    function resetAll(){
        thumbnailName = null;

        radioSelect3.reset();
        radioSelect4.reset();

        $step1.show();
        $step2.hide();
        $step3.hide();
        $step4.hide();
        $make.hide();
        $complete.hide();
        $('.event_detail').show();
        $('.event_howto').show();
        $('.event_head .inner').show();

        frameResize();
        setHeaderTop();
    }

    function moveFirstPage(){
        if(confirm('득템번역기 이벤트 초기화면으로 이동하시겠습니까?')){

            resetAll();
        }
    }

    //초기화면
    $('.event_head .title a').click(function(){
        moveFirstPage();
    });
    $('.step_menu_inner .c1 .step_txt').click(function(){
        moveFirstPage();
    });



    var gridWidth = 290;
    var $slideBtn = $('.slide_btn_wrap a');
    var currentSlideNum = -1;
    Draggable.create(".step3 .slide", {type:"x",  bounds:".step3 .tip .inner .slide_wrap", edgeResistance:0.8, throwProps:true,
        snap: {
            x: function(endValue) {
                currentSlideNum = Math.round(endValue / gridWidth) * -1;
                return Math.round(endValue / gridWidth) * gridWidth;
            }
        }, onDrag:function(){

        }, onDragEnd:function(){
            console.log(currentSlideNum);
            if(currentSlideNum < 0) currentSlideNum = 0;
            if(currentSlideNum >= $slideBtn.length) currentSlideNum = $slideBtn.length - 1;

            $slideBtn.removeClass('active');
            $slideBtn.eq(currentSlideNum).addClass('active');


        }
    });





    $('.step1 .next_btn').click(function(){

        if($.browser.desktop){
            alert('해당 이벤트는 모바일에서 참여 가능합니다.');
            return;
        }

        if( sns.checkInApp() ) {
            return false;
        }

        if(getRadioProduct()){
            $step1.hide();
            $step2.show();
            $('.event_detail').hide();
            $('.event_howto').hide();
            $('.event_head .inner').hide();
            frameResize();
            setHeaderTop();
            //window.location = "#step2";
        }else{
            alert('제품을 선택해 주세요.');
        }
    });




    $('.step2 .next_btn').click(function(){

        if(getRadioTo()){

            var name = getThumbnailName();
            var to = getRadioTo();

            if(name == "laptop"){
                if(to == "언니" || to == "오빠" || to == "형" || to == "누나" || to == "여보" || to == "자기"){
                    selectedImg = 1;
                }
            }
            if(name == "laptop"){
                if(to == "삼촌" || to == "이모" || to == "고모"){
                    selectedImg = 2;
                }
            }


            var n = $($radioTo).index($($radioTo).filter(":checked")) + 1;
            customMessage = message[name+n] +'<span class="footer"><span class="sharp">\n#</span>' + message.footer + '</span>';

            $step3.find('.selected_text .inner').html(customMessage);
            $make.find('.selected_text .inner').html(customMessage);
            $complete.find('.selected_text .inner').html(customMessage);

            $step3.find('.created_image .area > img').attr('src', imgServer + '/images/event2/thumb/fill_' + name + selectedImg + '.png');
            $step2.hide();
            $step3.show();

            frameResize();

        }else{
            alert("대상을 선택해 주세요.");
        }

    });

    $('.down_btn a').click(function(){

        var src = $(this).parent().prev().attr('src');

        window.open(src);


    });
    $('#finish_popup .btn1').click(function(){
        $('#finish_popup').hide();
        resetAll();
    });



    //파일찾기 업로드 버튼
    var isSubmit = false;
    var isSaveSubmit = false;
    var $uploadFormDiv = $('.upload_form');
    var $saveFormDiv = $('.complete_btn');



    function createForm(){

        var str = '';
        str += '<iframe src="" name="uploadIframe" width="1" height="1"></iframe>';
        $uploadFormDiv.html(str);
        str = '';
        str += '<form action="' + academyCustomURL + '/upload.php" method="post" enctype="multipart/form-data" id="uploadForm" target="uploadIframe">';
        str += '<label class="btn_file">';
        str += '<div id="fileName" class="filename"></div>';
        str += '<input type="file" name="uploaded_image" onchange="javascript:document.getElementById(\'fileName\').innerHTML = event2.getFilename(this.value)" onclick="eventTrack(\'event get translate_step5_activity search\', \'event get translate_step5_activity search\');">';
        str += '</label>';
        str += '<label class="btn_upload"><input type="submit" name="submit" value="upload" onclick="eventTrack(\'event get translate_step5_activity upload\', \'event get translate_step5_activity upload\');"></label>';
        str += '<input type="hidden" name="callbackURL" value="'+wasServer+'">';
        str += '</form>';
        $uploadFormDiv.append(str);

        str = '';
        str += '<form action="' + academyCustomURL + '/uploadbase64.php" method="post" enctype="multipart/form-data" id="saveForm" target="uploadIframe">';
        str += '<a class="btn_save" href="#" onclick="eventTrack(\'event get translate_step5_activity\', \'event get translate_step5_activity\');"></a>';
        str += '<input type="hidden" name="callbackURL" value="'+wasServer+'">';
        str += '<input type="hidden" name="img_data" id="imgData">';
        str += '</form>';

        $saveFormDiv.html(str);


        document.getElementById('uploadForm').onsubmit = function(){

            if($fileName.html() == ""){
                alert('사진을 업로드 해주세요.');
                return false;
            }

            if(isSubmit){
                return false;
            }
            $('.btn_upload').addClass('loading');
            isSubmit = true;


        };

        //득템짤 완성하기 버튼

        $btnSave = $('.btn_save');
        $btnSave.bind('click', function(){
            if(!academy.upload.isUploaded()){
                alert('사진을 업로드 해주세요.');
                return false;
            }
            if(isSaveSubmit){
                return false;
            }
            $btnSave.addClass('loading');
            isSaveSubmit = true;
            academy.upload.saveBase64();



        });

    }


    var $fileName = $('#fileName');
    //show make
    $('.step3 .make_btn').click(function(){

        createForm();

        $fileName.html('');
        $('.btn_upload').removeClass('loading');
        isSubmit = false;

        $btnSave.removeClass('loading');
        isSaveSubmit = false;

        academy.upload.reset();
        academy.upload.loadItemImage();

        $step3.hide();
        $make.show();
        $complete.hide();
        frameResize();

    });


    $('.step4 .re_btn').click(function(){
        resetAll();
    });






    var $resulty = $('.result_y');
    var $results = $('.result_s');
    var $resultn = $('.result_n');

    //당첨여부
    var nextStep = function(check){



        var tagStr1 = "eventTrack('event get translate_step5_option1_gift', 'event get translate_step5_option1_gift');";
        var tagStr2 = "eventTrack('event get translate_step5_option2_gift', 'event get translate_step5_option2_gift');";

        if(check == "y"){
            $resulty.show();
            $results.hide();
            $resultn.hide();
        }else if(check == "s"){
            $resulty.hide();
            $results.show();
            $resultn.hide();
        }else{
            tagStr1 = "eventTrack('event get translate_step5_option1_fail', 'event get translate_step5_option1_fail');";
            tagStr2 = "eventTrack('event get translate_step5_option2_fail', 'event get translate_step5_option2_fail');";
            $resulty.hide();
            $results.hide();
            $resultn.show();
        }

        $('.step4 .result .make_btn').attr('onclick', tagStr1);
        $('.step4 .result .view_btn').attr('onclick', tagStr2);


        console.log('insertComplete');
        $eventPopup.hide();
        $step3.hide();
        $step4.show();
        $make.hide();
        $complete.hide();

        frameResize();

    };


    var stepComplete = function(path){


        $make.hide();
        $complete.show();


        $uploadFormDiv.html('');
        $saveFormDiv.html('');

        $('.created_image .area .canvas_img').attr('src', path);

        frameResize();

    };


    var web = (function(){

        $('.visual.w .event_btn').click(function(){
            $('.visual.w .date_popup').show();
        });

        $('.visual.w .date_popup .close_btn').bind('click', function(){
            $('.visual.w .date_popup').hide();
        });


    }());



    return {

        stepComplete: stepComplete,
        nextStep: nextStep,
        getSelectImageName: function(){
            return getThumbnailName() + selectedImg;
        },
        getFilename: function (str) {
            return str.split('\\').pop().split('/').pop();
        },


        uploadComplete:uploadComplete

    }

}());




event2.submit = (function(){


    var $radioAgree1 = $('input[name=agree1]');
    var $radioAgree2 = $('input[name=agree2]');
    var $eventPopup = $('.event_popup');
    var $finishPopup = $('#finish_popup');
    var $detailPopup = $('.detail_popup');
    var $submitBtn = $('.submit_btn a');


    var radioSelect1 = new RadioSelect($radioAgree1);
    var radioSelect2 = new RadioSelect($radioAgree2);

    var insertComplete = function(check){

        $submitBtn.removeClass('loading');
        event2.nextStep(check);

        //if($( "#db_customize").val() == "Y"){
        //    alert('응모가 완료 되었습니다.');
        //    window.location.reload();
        //}else{
        //    event2.nextStep(check);
        //}

    };

    var $username = $('#username');
    var $phone1 = $('#phone1');
    var $phone2 = $('#phone2');
    var $phone3 = $('#phone3');


    function resetForm(){
        $username.val('');
        $phone1.val('');
        $phone2.val('');
        $phone3.val('');

        radioSelect1.reset();
        radioSelect2.reset();
    }

    TweenMax.set($detailPopup, {autoAlpha:0, 'display': 'block'});

    $($eventPopup).find('.close_btn').bind('click', function(){
        $eventPopup.hide();
    });
    $($detailPopup).find('.close_btn').bind('click', function(){
        TweenMax.to($detailPopup, 0.4, {autoAlpha:0});
    });
    $('.event_detail .desc_btn.btn1').click(function(){

        TweenMax.to($detailPopup, 0.4, {autoAlpha:1});
    });

    $('.step3 .kakao_btn').click(function(){
        $( "#db_product").val( $( "input[name=product]:checked" ).val() );
        $( "#db_person").val( $( "input[name=to]:checked" ).val() );
        $( "#db_select_img").val( $('.step3 .created_image .area > img').attr('src') );
        event2.submit.activePopup(5000);
    });

    $('.complete .kakao_btn').click(function(){
        $( "#db_product").val( $( "input[name=product]:checked" ).val() );
        $( "#db_person").val( $( "input[name=to]:checked" ).val() );
        $( "#db_customize").val( "Y" );
        $( "#db_select_img").val( $('.complete .created_image .area > img').attr('src') );
        event2.submit.activePopup(5000);
    });


    $submitBtn.bind('click', function(){

        if($(this).hasClass('loading')){
            return;
        }

        if($username.val() == ""){
            alert("이름을 입력해 주세요.");
            $username.focus();
            return;
        }
        if($phone1.val().length < 3){
            alert("연락처를 올바르게 입력해주세요.");
            $phone1.focus();
            return;
        }
        if($phone2.val().length < 3){
            alert("연락처를 올바르게 입력해주세요.");
            $phone2.focus();
            return;
        }
        if($phone3.val().length < 4){
            alert("연락처를 올바르게 입력해주세요.");
            $phone3.focus();
            return;
        }

        if($('input[name=agree1]').filter(":checked").val() == 'n'){
            alert('개인정보 수집이용 동의를 해주세요.');
            return;
        }
        if($('input[name=agree2]').filter(":checked").val() == 'n'){
            alert('개인정보 취급위탁 동의를 해주세요.');
            return;
        }

        eventTrack('event get translate_step4', 'event get translate_step4');

        $( "#db_phone").val( $phone1.val() + $phone2.val() + $phone3.val() );


        $(this).addClass('loading');
        setTimeout(function(){
            $submitBtn.removeClass('loading');
        }, 5000);

        document.getElementById('submitForm').submit();
    });





    return {
        activePopup:function(time){

            //alert('카카오톡 공유 후 페이지로 돌아와 개인정보를 입력해야 이벤트에 최종 응모됩니다.');
            resetForm();

            setTimeout( function() {
                $finishPopup.show();
            }, time );
        },
        insertComplete:insertComplete
    }

}());











