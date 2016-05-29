academy.dragcanvas = (function(){


    //var path = imgServer+"/images/test/silver.png";
    //var canvas = document.getElementById("dragCanvas");
    //var ctx = canvas.getContext("2d");
    //var canvasOffsetTop = canvas.offsetTop;
    //
    //var dragObj = {
    //    x:10, y:10, w:0, h:0, img:null, nw:0, nh:0
    //};
    //
    //$(canvas).bind('touchmove', function(event){
    //    var e = event.originalEvent;
    //    var touch = e.targetTouches[0];
    //    var touchPoint = {x:touch.pageX, y:touch.pageY-canvasOffsetTop};
    //    //console.log("pageX:"+touch.pageX+", pageY:"+(touch.pageY-canvasOffsetTop));
    //
    //    if(detectHit(dragObj.x, dragObj.y, touchPoint.x, touchPoint.y, dragObj.w, dragObj.h)) {
    //        // Assign new coordinates to our object
    //        //console.log(dragObj);
    //        dragObj.x = touchPoint.x - dragObj.nw;
    //        dragObj.y = touchPoint.y - dragObj.nh;
    //
    //        // Redraw the canvas
    //        draw();
    //    }
    //    //draw();
    //    event.preventDefault();
    //});
    //
    //
    //
    //
    //
    //function detectHit(x1,y1,x2,y2,w,h) {
    //    if((x2>x1 && x1+w > x2) && y2>y1 && y1+h > y2) return true;
    //    return false;
    //}
    //
    //
    //var loadImage = function(){
    //
    //    var img = new Image();
    //    img.onload = function(){
    //        ctx.drawImage(this,dragObj.x, dragObj.y);
    //        dragObj.img = this;
    //        dragObj.w = this.width;
    //        dragObj.h = this.height;
    //        dragObj.nw = this.width*0.5;
    //        dragObj.nh = this.height*0.5;
    //    };
    //    img.crossOrigin = "anonymous";
    //    img.src = path;
    //
    //};
    //
    //
    //function draw() {
    //
    //    // Clear the canvas
    //    ctx.clearRect(0, 0, canvas.width, canvas.height);
    //
    //
    //    // Draw our object in its new position
    //    ctx.drawImage(dragObj.img, dragObj.x, dragObj.y);
    //}


    return {
        init: function(){
            //loadImage();
        }
    }

}()).init();