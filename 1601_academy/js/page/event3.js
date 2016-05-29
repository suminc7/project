var event3 = (function(){

    var maxLengthListener = function(){
        //var $that = $(this),
        //    maxlength = $that.attr('maxlength');
        //if($.isNumeric(maxlength)){
        //    $that.val($that.val().substr(0, maxlength));
        //}

        if ($(this).val().length > $(this).attr('maxlength')) {
            $(this).val($(this).val().substr(0, $(this).attr('maxlength')));
        }
    };

    $("input[type=number]").on('keydown keyup', maxLengthListener);
    $("input[type=text]").on('keydown keyup', maxLengthListener);



    var $stepMain = $('.step_main');
    var $steps = $('.steps');
    var $step1 = $('.step1');
    var $step2 = $('.step2');
    var $step3 = $('.step3');
    var $radioProduct = $('input[name=product]');
    var $fileName = $('#fileName');
    var productIdx;
    var productArr = [
        'laptop',
        'printer',
        'monitor',
        'tablet'
    ];



    //step main
    $('.step_main .next_btn').bind('click', function(){

        //if(window.eventEnd){
        //    alert('이벤트가 종료 되었습니다.');
        //    return;
        //}




        if($.browser.msie && $.browser.version < 9){
            alert('해당 이벤트는 Explorer 9 이상 또는 Chrome 브라우저에서 참여 가능합니다.');

        }else if( sns.checkInApp( 4 ) ) {
			// do nothing
		}else{
            $stepMain.hide();
            $steps.show();
            $step1.show();
            $step2.hide();
            $step3.hide();


            //changeTemplate.call($template.eq(0));
            $radioProduct.eq(0).trigger('click');
            //radioProduct.reset();
        }


    });

    //$('.event_awards .ad_head .title').bind('click', function(){
    //    resetAll();
    //});




    /*
        ----------------------------- step1 -----------------------------
     */
    var radioProduct = new RadioSelect($radioProduct);
    var $template = $('.template');
    var $currentTemplate = null;
    var templateIdx = -1;

    function resetAll(){
        radioProduct.reset();


        $step1.show();
        $step2.hide();
        $step3.hide();

        $imgCanvas.show();
        $('.saveImg').remove();
		$('input[type=file]', $inputFileWrap).remove();
        $fileName.html('');

        $radioProduct.eq(0).trigger('click');

        event3.upload.reset();

        isInputFileChange = false;
    }

    function getRadioProduct(){
        return $($radioProduct).filter(":checked").val();
    }

    function drawCanvasImage(url){
        event3.upload.loadProductImage(url, function(path){
            $btnUploadWrap.removeClass('loading');
        });
    }


    //changed Template
    function activeTemplate(){
        if($currentTemplate){
            $currentTemplate.removeClass('active');
        }
        $(this).addClass('active');
        $currentTemplate = $(this);
        templateIdx = $(this).index();

        var path = imgServer + '/images/event3/template/';
        var url = path + 'large_' + productArr[productIdx] + '' + (templateIdx+1) + '.png';
        drawCanvasImage(url);
    }


    function changeTemplate(){
        productIdx = $(this).parent().parent().index();
        var path = imgServer + '/images/event3/template/';
        for (var i=0;i<$template.length;i++){
            var url = path + productArr[productIdx] + '' + (i+1) + '.png';
            $template.find('.template_img').eq(i).attr('src', url);
        }
        activeTemplate.call($template.eq(0));

        //$template
    }

    $template.bind('click', activeTemplate);

    $('.step1 .btn_wrap a').bind('click', function(){

        if(getRadioProduct()){
            $step1.hide();
            $step2.show();
            $step3.hide();

            appendInput();


        }else{
            alert('제품을 선택해 주세요.');
        }

    });

    $radioProduct.bind('click', changeTemplate);
    //changeTemplate.call($radioProduct.eq(0));



    /*
       ----------------------------- step2 -----------------------------
     */


    function appendInput(){
        var inputFile = '<input type="file" name="uploaded_image" onclick="eventTrack(\'event selfad award_file search\', \'event selfad award_file search\');">';
        var inputSubmit = '<input type="submit" name="submit" value="upload" onclick="eventTrack(\'event selfad award_file upload\', \'event selfad award_file upload\');">';

        $inputFileWrap.append(inputFile);
        $btnUploadWrap.append(inputSubmit);


        var $inputFile = $inputFileWrap.find('input');

        if($.browser.msie){
            $inputFile.addClass('ie');
        }

        $inputFile[0].onchange = function(){
            document.getElementById('fileName').innerHTML = getFilename(this.value);
            isInputFileChange = true;
        };

    }

    function removeInput(){

        $('input[type=file]', $inputFileWrap).remove();
        $('input[type=submit]', $btnUploadWrap).remove();

    }


    var $imgCanvas = $('#imageCanvas');
    var $imgCanvasWrap = $('.imageCanvas');
    var $btnSave = $('.step2 .btn_wrap a');
    var $inputFileWrap = $('.inputfile');
    var $btnUploadWrap = $('.btn_upload');
    var isInputFileChange = false;




    document.getElementById('uploadForm').onsubmit = function(){
        if($btnUploadWrap.hasClass('loading')){
            return;
        }

        if(!isInputFileChange){
            alert('사진을 업로드 해주세요.');
            return false;
        }

        $btnUploadWrap.addClass('loading');
    };


    $btnSave.bind('click', function(){
        if(!event3.upload.isUploaded()){
            alert('사진을 업로드 해주세요.');
            return false;
        }
        if($btnSave.hasClass('loading')){
            return;
        }
        $btnSave.addClass('loading');

        event3.upload.saveBase64(function(path){


            $btnSave.removeClass('loading');

            removeInput();

            $step1.hide();
            $step2.hide();
            $step3.show();
            $imgCanvas.hide();



            var img = new Image();
            img.crossorigin = "anonymous";
            img.src = path;
            img.className = 'saveImg';
            $imgCanvasWrap.append(img);
        });

    });


    /*
     ----------------------------- step3 -----------------------------
     */

    $('.step3 .restart_btn').bind('click', function(){
        resetAll();
    });

    $('.step3 .down_btn').bind('click', function(){
        var url = $('.saveImg').eq(0).attr('src');
        window.open(url);
    });

    var isCheck = false;
    var $checkBox = $('.step3 .checkbox');
    $checkBox.bind('click', function(){
        if(isCheck){
            $(this).removeClass('on');
            isCheck = false;
        }else{
            $(this).addClass('on');
            isCheck = true;
        }
    });



	var setProduct = function( prod ) {
		$( "input[name=product][value=" + prod + "]").attr( "checked", true );
	};
	var setImgType	= function( img_type ) {
		templateIdx = img_type;
	};
	var setSaveImage = function( img ) {
		$('.saveImg').val( img );
	};


    return {
        templateIdx:function(){
            return templateIdx;
        },
        getRadioProduct:function(){
            return getRadioProduct();
        },
		setProduct : setProduct,
		setImgType : setImgType,
		setSaveImage : setSaveImage,

        onSns: function(type){

            if(!$checkBox.hasClass('on')){
                alert('사용 이미지 관련 체크박스를 확인해주세요.');
                return;
            }

            if(type == 'fb'){
                sns.share('fb', 3);
            }else if(type == 'tw'){
                sns.share('tw', 3);
            }else if(type == 'insta'){
                event3.submit.onPopup('insta');
            }else if(type == 'ks'){
                sns.share('ks', 3);
            }

        }

    }
}());


event3.share = (function(){


    /*
        youtube
     */

    var videoArr = [
        'x2HkvKFYt6w',
        'WPfws8-EavE'
    ];

    var $thumbBtn = $('.thumb a');
    var $currentThumb = $thumbBtn.eq(0);
    var $iframe = $('.youtube iframe');
    var idx = -1;

    var thumbnailListener = function(){
        if($currentThumb)$currentThumb.removeClass('active');
        var $self = $(this);
        $self.addClass('active');
        $currentThumb = $self;
        idx = $self.parent().index();

        $iframe.attr('src', 'https://www.youtube.com/embed/' + videoArr[idx] + '?wmode=opaque&rel=0');
    };
    $thumbBtn.bind('click', thumbnailListener);


	var setIdx = function( num ) {
		idx = num;
	};


    return {
        idx: function(){
			if( idx == -1 )
				idx = 0;

            return idx;
        }
		, setIdx : setIdx
    }
}());


event3.submit = (function(){


    var $eventPopup = $('.submit_popup');

    $eventPopup.each(function(){

        var $self = $(this);
        var $username = $self.find('.username');
        var $phone1 = $self.find('input[name=phone1]');
        var $phone2 = $self.find('input[name=phone2]');
        var $phone3 = $self.find('input[name=phone3]');
        var $instaID = $self.find('.insta_id');
        var $submitBtn = $self.find('.submit_btn a');
        var form = $self.find('form')[0];


        var radioNameArr = [];
        var radioInstanceArr = [];
        var radioAlertArr = [
            '개인정보 수집이용 동의를 해주세요.',
            '개인정보 취급위탁 동의를 해주세요.',
            '응모 콘텐츠 이용에 대한 동의를 해주세요.'
        ];

        //중복 체크
        $self.find('input[type=radio]').each(function(){
            var nameCheck = true;
            for(var i=0;i<radioNameArr.length;i++){
                if(radioNameArr[i] == this.name){
                    nameCheck = false;
                    break;
                }
            }
            if(nameCheck){
                radioNameArr.push(this.name);
            }
        });

        //생성
        for(var i=0;i<radioNameArr.length;i++){
            var radioSelect = new RadioSelect($('input[name='+radioNameArr[i]+']'));
            radioInstanceArr.push(radioSelect);
        }

        var closeListener = function(){
            if(parent.location.href.indexOf( "eventNum" ) > 0 ){
				var loc			= parent.location.href;
				var eventNumber	= loc.substr( loc.indexOf( "eventNum::" ) + "eventNum::".length, 1 );
				eventNumber		= eventNumber == 3 ? 4 : 3;
                if(parent.location.href.indexOf( "samsung.com" ) > 0){
                    parent.window.location = "http://www.samsung.com/sec/academy/event" + eventNumber + "/index.html";
                }else{
                    parent.window.location = "/comLocal/event/1601_academy/sds/event" + eventNumber + ".html";
                }
            }
            $self.hide();
        };

        $self.find('.inner .close_btn , .inner .btn_confirm').bind('click', closeListener);
        $self.find('.complete_popup .close_btn').bind('click', closeListener);


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
                alert("연락처를 올바르게 입력해 주세요.");
                $phone1.focus();
                return;
            }
            if($phone2.val().length < 3){
                alert("연락처를 올바르게 입력해 주세요.");
                $phone2.focus();
                return;
            }
            if($phone3.val().length < 4){
                alert("연락처를 올바르게 입력해 주세요.");
                $phone3.focus();
                return;
            }

            if($instaID.length > 0){
                if($instaID.val() == ""){
                    alert("인스타그램 아이디를 입력해 주세요.");
                    $instaID.focus();
                    return;
                }
            }

            for(var i=0;i<radioInstanceArr.length;i++){
                var agreeRadio = radioInstanceArr[i];
                if(agreeRadio.radio.filter(":checked").val() != 'y'){
                    alert(radioAlertArr[i]);
                    return;
                }
            }

            var device = 'm';
            if($.browser.desktop){
                device = 'w';
            }



            $self.find('input[name=user_phone]').val($phone1.val() + $phone2.val() + $phone3.val());
            $self.find('input[name=device]').val( device );
            $self.find('input[name=sns_type]').val( snsType );

            if($self.attr('id') == 'share_popup'){
                //movie share
                $self.find('input[name=episode]').val( event3.share.idx() );
            }else{
                //awards
                $self.find('input[name=product]').val( event3.getRadioProduct() );
                $self.find('input[name=img_type]').val( event3.templateIdx() );
                $self.find('input[name=image]').val( $( $('.saveImg')[0] ).attr('src').replace( "_awards.jpg", ".jpg").replace( ".jpg", "_awards.jpg" ) );
            }



            $currentPopup = $self;

            $(this).addClass('loading');
            setTimeout(function(){
                $submitBtn.removeClass('loading');
            }, 3000);



            if($self.attr('id') == 'share_popup'){
                eventTrack('event selfad share vod_apply', 'event selfad share vod_apply');
            }else if($self.attr('id') == 'awards_popup'){
                eventTrack('event selfad award_apply', 'event selfad award_apply');
            }else if($self.attr('id') == 'insta_popup'){
                eventTrack('event selfad award_instagram_apply', 'event selfad award_instagram_apply');
            }


            form.submit();
        });

        this.reset = function(){
            $currentPopup = null;

            $username.val('');
            $phone1.val('');
            $phone2.val('');
            $phone3.val('');

            $self.find('input[name=user_phone]').val('');
            $self.find('input[name=device]').val('');
            $self.find('input[name=product]').val('');
            $self.find('input[name=img_type]').val('');
            $self.find('input[name=image]').val('');
            $self.find('input[name=sns_type]').val('');

            for(var i=0;i<radioInstanceArr.length;i++){
                radioInstanceArr[i].reset();
            }
        }


    });

    var $awardsPopup = $('#awards_popup');
    var $instaPopup = $('#insta_popup');
    var $sharePopup = $('#share_popup');
    var snsType = null;
    var $currentPopup;

    function reset(){
        $eventPopup.each(function(){
           this.reset();
        });
        snsType = null;
        $currentPopup = null;
    }

    return {
        onPopup: function(type){


            if(type == "fb"){
                $currentPopup = $awardsPopup;
            }else if(type == "tw"){
                $currentPopup = $awardsPopup;
            }else if(type == "insta"){
                $currentPopup = $instaPopup;
            }else if(type == "ks"){
                $currentPopup = $awardsPopup;
            }

            snsType = type;


            $currentPopup.show();
            $currentPopup.find('.box .inner').show();
            $currentPopup.find('.complete_popup').hide();

        },

        onSharePopup: function(type){

            $currentPopup = $sharePopup;
            snsType = type;

            $currentPopup.show();
            $currentPopup.find('.box .inner').show();
            $currentPopup.find('.complete_popup').hide();

        },

        submitComplete: function(){

            $currentPopup.find('.box .inner').hide();
            $currentPopup.find('.complete_popup').show();

            setTimeout(function(){
                reset();
            }, 1000);

            if(snsType == "fb"){

            }else if(snsType == "tw"){

            }else if(snsType == "insta"){

            }else if(snsType == "ks"){

            }
        },

        downImage: function(){
            var src = $('.saveImg').attr('src');
            window.open(src);
        }

    }

}());


event3.gallery = (function(){

    var $list = $('.gallery_contents .list_btn ');
    var $galleryPopup = $('#gallery_popup');
    var $schedulePopup = $('#schedule_popup');
    var $userImg = $('#gallery_popup .user_image');

    $galleryPopup.find('.inner .close_btn').bind('click', function(){
        $galleryPopup.hide();
    });
    $schedulePopup.find('.inner .close_btn').bind('click', function(){
        $schedulePopup.hide();
    });

    $('.event_gallery .winner_btn .btn1').click(function(){
        $schedulePopup.show();
    });

    $list.each(function(){
        this.$over = $(this).find('.over');
        this.$txt = $(this).find('.over .txt');
        this.imgPath = $(this).find('.thumb').attr('src');

        TweenMax.set(this.$over, {autoAlpha:0, display:'block'});
        TweenMax.set(this.$txt, {y:3});
    });

    $list.bind('mouseenter', function(){
       $(this).addClass('on');

        TweenMax.to(this.$over, 0.2, {autoAlpha:1});
        TweenMax.to(this.$txt, 0.2, {y:0, ease:Power1.easeInOut});

    });
    $list.bind('mouseleave', function(){
        $(this).removeClass('on');

        TweenMax.to(this.$over, 0.2, {autoAlpha:0});
        TweenMax.to(this.$txt, 0.2, {y:3, ease:Power1.easeInOut});
    });

    $list.bind('click', function(){


        var img = new Image();
        img.onload = function(){
            $userImg.find('img').attr('src', this.src);
            setTimeout(function(){
                $galleryPopup.show();
            }, 100);
        };
        img.src = this.imgPath;

    });


    return {

    }
}());



event3.head = (function(){



    var $eventShare = $('#event_share');
    var $eventAwards = $('#event_awards');
	var $eventShareApply = $("#share_popup .box");
	var $eventAwardsApply = $("#awards_popup .box");
    var $parentHeader = parent.$('#header');

    var parentHeaderHeight = $parentHeader.length > 0 ? $parentHeader[0].clientHeight : 0;

    function moveEvent1(){
        setScrollTop($eventShare.offset().top + parentHeaderHeight);
    }
    function moveEvent2(){
        setScrollTop($eventAwards.offset().top + parentHeaderHeight);
    }
	function moveEvent1Apply() {
        setScrollTop($eventShareApply.offset().top + parentHeaderHeight - 30);
	}
	function moveEvent2Apply() {
        setScrollTop($eventAwardsApply.offset().top + parentHeaderHeight - 30);
	}

    function setScrollTop(top) {
        parent.$('html,body').stop().animate({"scrollTop":top}, 400);
    }


    $('.move_event1').bind('click', function(){
        moveEvent1();
    });
    $('.move_event2').bind('click', function(){
        moveEvent2();
    });

    $('.event_share .detail_btn a').bind('click', function(){
        moveEvent2();
    });


    parent.$(window).load(function(){

        setTimeout(function(){
            if(getURLParameter('type') == 'event3'){
                academy.gnb.active(2,0);

                if(parent.location.href.indexOf( "eventNum" ) > 0 ){
                    moveEvent1Apply();
                }else{
                    //moveEvent1();
                }

            }else if(getURLParameter('type') == 'event4'){
                academy.gnb.active(2,1);

                if(parent.location.href.indexOf( "eventNum" ) > 0 ){
                    moveEvent2Apply();
                }else{
                    moveEvent2();
                }
            }

        }, 500);


    });




    return {
        moveToEvent1: moveEvent1,
        moveToEvent2: moveEvent2,
		moveToEvent1Apply: moveEvent1Apply,
		moveToEvent2Apply: moveEvent2Apply
    }

}());









