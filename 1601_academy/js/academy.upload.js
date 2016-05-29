academy.upload = (function () {

    var canvas = document.getElementById("imageCanvas");
    var ctx = canvas.getContext("2d");
    var dragObj = {x:0, y:0, w:0, h:0, img:null, nw:0, nh:0};
    var uploadObj = {x:0, y:0, img:null};
    var saveForm = null;

    var imgWid = 580, imgHei = 320;
    var mx = imgWid*0.5, my = imgHei*0.5;

    var nx=0,ny= 0,sx,sy;

    var scale = 0;
    var isUploaded = false;

    var draggable = null;

    function reset(){

        isUploaded = true;

        setScalePosition();

        draggable = Draggable.create(".drag_btn", {type:"x",  bounds:".drag_wrap", throwProps:true, onDrag:onDragListener, onDragEnd:dragEnd});
        draggable[0].x = draggable[0].maxX/2;
        TweenMax.set(".drag_btn", {x:draggable[0].x});
        onDragListener.call(draggable[0]);
    }

    function onDragListener(){
        scale = 0.3 + this.x/this.maxX;
        draw();
    }

    function dragEnd(){
        if((uploadObj.x+sx) > mx){
            TweenMax.to(uploadObj, 0.3, {x:mx-sx, onUpdate:draw});
        }else if((uploadObj.x+sx) + (uploadObj.img.width * scale) < mx){
            TweenMax.to(uploadObj, 0.3, {x:-sx-(uploadObj.img.width * scale)+mx, onUpdate:draw});
        }


        if((uploadObj.y+sy) > my){
            TweenMax.to(uploadObj, 0.3, {y:my-sy, onUpdate:draw});
        }else if((uploadObj.y+sy) + (uploadObj.img.height * scale) < my){
            TweenMax.to(uploadObj, 0.3, {y:-sy-(uploadObj.img.height * scale)+my, onUpdate:draw});
        }
    }



    $(canvas).bind('touchstart', function(event){
        var e = event.originalEvent;
        var touch = e.targetTouches[0];
        nx = touch.pageX - uploadObj.x;
        ny = touch.pageY - uploadObj.y;


    });

    $(canvas).bind('touchmove', function(event){
        var e = event.originalEvent;
        var touch = e.targetTouches[0];
        var touchPoint = {x:touch.pageX, y:touch.pageY};

        uploadObj.x = touchPoint.x - nx;
        uploadObj.y = touchPoint.y - ny;
        draw();


        event.preventDefault();
    });

    $(canvas).bind('touchend', function(event){

        dragEnd();

        event.preventDefault();
    });

    var saveComplete = function(path){
        console.log('saveComplete');
        event2.stepComplete(path);
    };

    var uploadComplete = function(path){
        console.log('uploadComplete : ' + path);
        var url2 = wasServer + "/upload/showImage.jsp?image=" + path;
        loadImage(url2);

    };

    var loadImage = function(path){

        var img = new Image();
        img.onload = function(){
            event2.uploadComplete();

            uploadObj.img = this;
            uploadObj.x = imgWid/2 - this.width/2, uploadObj.y = imgHei/2 - this.height/2, uploadObj.w = this.width, uploadObj.h = this.height, uploadObj.nw = this.width*0.5, uploadObj.nh = this.height*0.5;
            draw();

            reset();
        };

        img.crossorigin = "anonymous";
        img.src = path;
    };


    var loadItemImage = function(){
        var path = imgServer + "/images/event2/thumb/empty_" + event2.getSelectImageName() + ".png";
        path = wasServer + "/upload/showImage.jsp?image=" + path;

        var img = new Image();
        img.onload = function(){
            dragObj.img = this;
            dragObj.w = this.width, dragObj.h = this.height, dragObj.nw = this.width*0.5, dragObj.nh = this.height*0.5;
            draw();
        };
        img.crossorigin = "anonymous";
        img.src = path;

    };

    function setScalePosition(){
        sx = (uploadObj.img.width - uploadObj.img.width * scale) * 0.5;
        sy = (uploadObj.img.height - uploadObj.img.height * scale) * 0.5;
    }


    function draw() {

        ctx.clearRect(0, 0, canvas.width, canvas.height);
        if(uploadObj.img){
            setScalePosition();
            ctx.drawImage(uploadObj.img, uploadObj.x + sx, uploadObj.y + sy, uploadObj.img.width * scale, uploadObj.img.height * scale);
        }
        if(dragObj.img) ctx.drawImage(dragObj.img, dragObj.x, dragObj.y, imgWid, imgHei);
    }


    var saveBase64 = function(){
        try{
            var dataURL = canvas.toDataURL('image/png');
            var img = '<img src="'+dataURL+'" alt="" />';
        }catch(e){
            alert(e);
        }

        $(img).load(function(){
            $('#imgData').val(dataURL);
            document.getElementById("saveForm").submit();
        });


    };


    return {
        saveBase64: saveBase64,
        saveComplete: saveComplete,
        uploadComplete: uploadComplete,
        loadItemImage: loadItemImage,
        reset: function(){
            uploadObj.img = null;
        },
        isUploaded: function(){
            return isUploaded;
        }
    }

}());