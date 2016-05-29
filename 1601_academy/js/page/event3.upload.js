




event3.upload = (function(){



    if($.browser.msie && $.browser.version < 9){
        return;
    }


    var canvas = document.getElementById("imageCanvas");
    var ctx = canvas.getContext("2d");
    var dragObj = {x:0, y:0, w:0, h:0, img:null, nw:0, nh:0};
    var uploadObj = {x:0, y:0, img:null};
    var logoObj = {x:0, y:0, img:null};
    var scale = 1;
    var nx=0,ny= 0,sx,sy;
    var imgWid = 350, imgHei = 350;
    var mx = imgWid*0.5, my = imgHei*0.5;
    var isUploaded = false;
    var saveCallback = null;
    var uploadCallack = null;
    var offset = 5;

    var draggable;


    /*
     load Image
     */

    var loadLogoImage = function(){

        var url = 'http://images.s-academy.co.kr/logo.png';
        var path = wasServer + "/upload/showImage.jsp?image=" + url;

        var img = new Image();
        img.onload = function(){

            logoObj.img = this;
            logoObj.x = 0;
            logoObj.y = 0;
            logoObj.w = this.width;
            logoObj.h = this.height;
            draw();
        };

        img.crossorigin = "anonymous";
        img.src = path;
    };
    loadLogoImage();

    var loadProductImage = function(url, callback){
        uploadCallack = callback;

        var path = wasServer + "/upload/showImage.jsp?image=" + url;

        var img = new Image();
        img.onload = function(){
            dragObj.img = this;
            dragObj.x = imgWid/2 - this.width/2;
            dragObj.y = imgHei/2 - this.height/2;
            dragObj.w = this.width;
            dragObj.h = this.height;
            dragObj.nw = this.width*0.5;
            dragObj.nh = this.height*0.5;
            draw();
        };
        img.crossorigin = "anonymous";
        img.src = path;

    };

    var loadUploadImage = function(url){


        if(url == ""){
            uploadCallack.call(null, url);
            return;
        }


        var path = wasServer + "/upload/showImage.jsp?image=" + url;

        var img = new Image();
        img.onload = function(){

            isUploaded = true;

            uploadCallack.call(null, url);

            uploadObj.img = this;
            uploadObj.x = imgWid/2 - this.width/2;
            uploadObj.y = imgHei/2 - this.height/2;
            uploadObj.w = this.width;
            uploadObj.h = this.height;
            uploadObj.nw = this.width*0.5;
            uploadObj.nh = this.height*0.5;
            draw();

            reset();
        };

        img.crossorigin = "anonymous";
        img.src = path;
    };

    var saveComplete = function(path){
        $('#imgData').val('');
        saveCallback.call(null, path);
    };

    var offsetScale = 0.7;
    function setScalePosition(){
        sx = (dragObj.img.width - dragObj.img.width * scale * offsetScale) * 0.5;
        sy = (dragObj.img.height - dragObj.img.height * scale * offsetScale) * 0.5;
    }


    function draw() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        if(uploadObj.img){
            ctx.drawImage(uploadObj.img, uploadObj.x, uploadObj.y, uploadObj.img.width, uploadObj.img.height);
        }
        if(dragObj.img) {
            setScalePosition();
            ctx.drawImage(dragObj.img, dragObj.x + sx, dragObj.y + sy, dragObj.img.width * scale * offsetScale, dragObj.img.height * scale * offsetScale);
        }

        if(logoObj.img) {
            ctx.drawImage(logoObj.img, logoObj.x, logoObj.y, imgWid, imgHei);
        }
    }



    function onDragListener(){
        var per = this.x/this.maxX;
        scale = 1 + (per*0.4-0.2);
        draw();
    }

    function dragEnd(){
        if(dragObj.x+sx < 0){
            TweenMax.to(dragObj, 0.3, {x:-sx + offset, onUpdate:draw});
        }else if((dragObj.x+sx) + (dragObj.img.width * scale * offsetScale) > imgWid){
            TweenMax.to(dragObj, 0.3, {x:imgWid - (dragObj.img.width * scale * offsetScale) - sx - offset, onUpdate:draw});
        }


        if(dragObj.y+sy < 0){
            TweenMax.to(dragObj, 0.3, {y:-sy + offset, onUpdate:draw});
        }else if((dragObj.y+sy) + (dragObj.img.height * scale * offsetScale) > imgHei){
            TweenMax.to(dragObj, 0.3, {y:imgHei - (dragObj.img.height * scale * offsetScale) - sy - offset, onUpdate:draw});
        }


    }

    function reset(){
        setScalePosition();

        draggable = Draggable.create(".drag_btn", {type:"x",  bounds:".drag_bar", throwProps:false, onDrag:onDragListener, onDragEnd:dragEnd});
        setDrag(draggable[0].maxX/2);
    }

    function setDrag(nx){
        draggable[0].x = nx;
        TweenMax.set(".drag_btn", {x:draggable[0].x});
        onDragListener.call(draggable[0]);
    }


    function saveBase64(callback){
        saveCallback = callback;
        var dataURL, img;
        try{
            if($.browser.android){
                dataURL = canvas.toDataURL('image/png');
            }else{
                dataURL = canvas.toDataURL('image/jpeg', 0.9);
            }
        }catch(e){
            alert(e);
        }
        img = new Image();
        img.onload = function(){
            $('#imgData').val(img.src);
            document.getElementById("saveForm").submit();
        };
        img.src = dataURL;


    }


    var touchStartListener = function(event){
        if(isUploaded){
            var e = event.originalEvent, touch = e.targetTouches ? e.targetTouches[0] : e;
            nx = touch.pageX - dragObj.x;
            ny = touch.pageY - dragObj.y;
        }
        $(document).bind('touchmove mousemove', touchMoveListener);
        $(document).bind('touchend mouseup', touchEndListener);
        event.preventDefault();

    };

    var touchMoveListener = function(event){
        if(isUploaded){
            var e = event.originalEvent, touch = e.targetTouches ? e.targetTouches[0] : e;
            var touchPoint = {x:touch.pageX, y:touch.pageY};

            dragObj.x = touchPoint.x - nx;
            dragObj.y = touchPoint.y - ny;
            draw();
        }
        event.preventDefault();

    };
    var touchEndListener = function(event){
        if(isUploaded){
            dragEnd();
        }
        $(document).unbind('touchmove mousemove', touchMoveListener);
        $(document).unbind('touchend mouseup', touchEndListener);
        event.preventDefault();
    };


    $(canvas).bind('touchstart mousedown', touchStartListener);




    return {
        saveBase64: saveBase64,
        loadProductImage:loadProductImage,
        loadUploadImage:loadUploadImage,
        saveComplete:saveComplete,
        isUploaded: function(){
            return isUploaded;
        },
        reset: function(){
            uploadObj.img = null;
            isUploaded = false;
            setDrag(0);
            scale = 1;
        }

    }
}());
