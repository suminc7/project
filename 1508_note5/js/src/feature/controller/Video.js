




define([
    'feature/controller/StepVideo'
], function (StepVideo) {

    var parents;




    if(ie8) {


        $('.box .item .videocontent').addClass('ie8');


    }else{

        var videoArr = [];



        var spen1 = new StepVideo();
        spen1.step = 2;
        spen1.obj = $('.spen .item2 .content');
        //spen1.url = '<video class="video" width="1920" height="800"  poster="'+imgServerDomain+'/images/video/s-pen.start.jpg"><source src="'+imgServerDomain+'/images/video/s-pen.mp4" type="video/mp4"></video>';
        spen1.poster = imgServerDomain+'/images/video/s-pen.start.jpg';
        spen1.source = imgServerDomain+'/images/video/s-pen.mp4';
        spen1.width = 1920;
        spen1.height = 800;

        var spen2 = new StepVideo();
        spen2.step = 3;
        spen2.obj = $('.spen .item3 .content');
        //spen2.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/2D/S-PEN-memo-first.jpg"><source src="'+imgServerDomain+'/images/video/2D/S-PEN-memo.mp4" type="video/mp4"></video>';
        spen2.poster = imgServerDomain+'/images/video/2D/S-PEN-memo-first.jpg';
        spen2.source = imgServerDomain+'/images/video/2D/S-PEN-memo.mp4';
        spen2.width = 1440;
        spen2.height = 800;



        var spen3 = new StepVideo();
        spen3.step = 4;
        spen3.obj = $('.spen .item4 .content');
        //spen3.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/2D/air-commend_first.jpg"><source src="'+imgServerDomain+'/images/video/2D/air-commend.mp4" type="video/mp4"></video>';
        spen3.poster = imgServerDomain+'/images/video/2D/air-commend_first.jpg';
        spen3.source = imgServerDomain+'/images/video/2D/air-commend.mp4';
        spen3.width = 1440;
        spen3.height = 800;

        var spen4 = new StepVideo();
        spen4.step = 5;
        spen4.obj = $('.spen .item5 .content');
        //spen4.url = '<video class="video" width="1920" height="800"  poster="'+imgServerDomain+'/images/video/2D/scroll-capture_first.jpg"><source src="'+imgServerDomain+'/images/video/2D/scroll-capture.mp4" type="video/mp4"></video>';
        spen4.poster = imgServerDomain+'/images/video/2D/scroll-capture_first.jpg';
        spen4.source = imgServerDomain+'/images/video/2D/scroll-capture.mp4';
        spen4.width = 1920;
        spen4.height = 800;





        var design1 = new StepVideo();
        design1.step = 6;
        design1.obj = $('.design .item1 .content');
        //design1.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/design_main.start.jpg"><source src="'+imgServerDomain+'/images/video/design_main.mp4" type="video/mp4"></video>';
        design1.poster = imgServerDomain+'/images/video/design_main.start.jpg';
        design1.source = imgServerDomain+'/images/video/design_main.mp4';
        design1.width = 1440;
        design1.height = 800;



        var design2 = new StepVideo();
        design2.step = 9;
        design2.obj = $('.design .item3 .content');
        //design2.url = '<video class="video" width="1920" height="800"  poster="'+imgServerDomain+'/images/video/2D/metal-glass.jpg"><source src="'+imgServerDomain+'/images/video/2D/metal-glass.mp4" type="video/mp4"></video>';
        design2.poster = imgServerDomain+'/images/video/2D/metal-glass.jpg';
        design2.source = imgServerDomain+'/images/video/2D/metal-glass.mp4';
        design2.width = 1920;
        design2.height = 800;




        /*
            pay
         */



        var pay1 = new StepVideo();
        pay1.step = 10;
        pay1.obj = $('.pay .item1 .content');
        pay1.poster = imgServerDomain+'/images/video/2D/pay-gate-first.jpg';
        pay1.source = imgServerDomain+'/images/video/2D/pay-gate.mp4';
        pay1.width = 1440;
        pay1.height = 800;



        var pay2 = new StepVideo();
        pay2.step = 12;
        pay2.obj = $('.pay .item3 .content');
        //pay2.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/2D/paycard-first.jpg"><source src="'+imgServerDomain+'/images/video/2D/paycard.mp4" type="video/mp4"></video>';
        pay2.poster = imgServerDomain+'/images/video/2D/paycard-first.jpg';
        pay2.source = imgServerDomain+'/images/video/2D/paycard.mp4';
        pay2.width = 1440;
        pay2.height = 800;


        /*
         charge
         */
        var charge1 = new StepVideo();
        charge1.step = 13;
        charge1.obj = $('.charge .item1 .content');
        //charge1.url = '<video class="video" width="1920" height="800"  poster="'+imgServerDomain+'/images/video/charging-main.start.jpg"><source src="'+imgServerDomain+'/images/video/charging-main.mp4" type="video/mp4"></video>';
        charge1.poster = imgServerDomain+'/images/video/charging-main.start.jpg';
        charge1.source = imgServerDomain+'/images/video/charging-main.mp4';
        charge1.width = 1920;
        charge1.height = 800;


        var charge2 = new StepVideo();
        charge2.step = 14;
        charge2.obj = $('.charge .item2 .content');
        //charge2.url = '<video class="video" width="1920" height="800"  poster="'+imgServerDomain+'/images/video/2D/quick-charge-first.jpg"><source src="'+imgServerDomain+'/images/video/2D/quick-charge.mp4" type="video/mp4"></video>';
        charge2.poster = imgServerDomain+'/images/video/2D/quick-charge-first.jpg';
        charge2.source = imgServerDomain+'/images/video/2D/quick-charge.mp4';
        charge2.width = 1920;
        charge2.height = 800;

        /*
            camera
         */
        var camera3 = new StepVideo();
        camera3.step = 20;
        camera3.obj = $('.camera .item5 .content');
        //camera3.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/cam-ois.start.jpg"><source src="'+imgServerDomain+'/images/video/cam-ois.mp4" type="video/mp4"></video>';
        camera3.poster = imgServerDomain+'/images/video/cam-ois.start.jpg';
        camera3.source = imgServerDomain+'/images/video/cam-ois.mp4';
        camera3.width = 1440;
        camera3.height = 800;



        var camera2 = new StepVideo();
        camera2.step = 17;
        camera2.obj = $('.camera .item2 .content');
        //camera2.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/2D/quick-camera-note-first.jpg"><source src="'+imgServerDomain+'/images/video/2D/quick-camera-note.mp4" type="video/mp4"></video>';
        camera2.poster = imgServerDomain+'/images/video/2D/quick-camera-pink-first.jpg';/* '/images/video/2D/quick-camera-first.jpg' */
        camera2.source = imgServerDomain+'/images/video/2D/quick-camera-pink.mp4';/* '/images/video/2D/quick-camera.mp4' */
        camera2.width = 1440;
        camera2.height = 800;

        var camera1 = new StepVideo();
        camera1.step = 16;
        camera1.obj = $('.camera .item1 .content');
        //camera1.url = '<video class="video" width="1920" height="800"  poster="'+imgServerDomain+'/images/video/camera-main.start.jpg"><source src="'+imgServerDomain+'/images/video/camera-main.mp4" type="video/mp4"></video>';
        camera1.poster = imgServerDomain+'/images/video/camera-main.start.jpg';
        camera1.source = imgServerDomain+'/images/video/camera-main.mp4';
        camera1.width = 1920;
        camera1.height = 800;


        /*
         entertainment
         */

        var enter1 = new StepVideo();
        enter1.step = 21;
        enter1.obj = $('.entertainment .item1 .content');
        //enter1.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/entertainment-main.start.jpg"><source src="'+imgServerDomain+'/images/video/entertainment-main.mp4" type="video/mp4"></video>';
        enter1.poster = imgServerDomain+'/images/video/entertainment-main.start.jpg';
        enter1.source = imgServerDomain+'/images/video/entertainment-main.mp4';
        enter1.width = 1440;
        enter1.height = 800;

        var enter2 = new StepVideo();
        enter2.step = 22;
        enter2.obj = $('.entertainment .item2 .liveicon');
        //enter2.url = '<video class="video" width="270" height="140"  poster="'+imgServerDomain+'/images/video/2D/live-icon_first.jpg"><source src="'+imgServerDomain+'/images/video/2D/live-icon.mp4" type="video/mp4"></video>';
        enter2.poster = imgServerDomain+'/images/video/2D/live-icon_first.jpg';
        enter2.source = imgServerDomain+'/images/video/2D/live-icon.mp4';
        enter2.width = 300;
        enter2.height = 140;

        var enter3 = new StepVideo();
        enter3.step = 24;
        enter3.obj = $('.entertainment .item2 .graph');
        //enter3.url = '<video class="video" width="280" height="170"  poster="'+imgServerDomain+'/images/video/2D/uhqaudio-icon_first.jpg"><source src="'+imgServerDomain+'/images/video/2D/uhqaudio-icon.mp4" type="video/mp4"></video>';
        enter3.poster = imgServerDomain+'/images/video/2D/uhqaudio-icon_first.jpg';
        enter3.source = imgServerDomain+'/images/video/2D/uhqaudio-icon.mp4';
        enter3.width = 280;
        enter3.height = 170;





        /*
         perfor
         */
        var perfor1 = new StepVideo();
        perfor1.step = 25;
        perfor1.obj = $('.performance .item1 .content');
        //perfor1.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/2D/performance-gate-first.jpg"><source src="'+imgServerDomain+'/images/video/2D/performance-gate.mp4" type="video/mp4"></video>';
        perfor1.poster = imgServerDomain+'/images/video/2D/performance-gate-first.jpg';
        perfor1.source = imgServerDomain+'/images/video/2D/performance-gate.mp4';
        perfor1.width = 1440;
        perfor1.height = 800;


        var perfor2 = new StepVideo();
        perfor2.step = 26;
        perfor2.obj = $('.performance .item2 .content');
        //perfor2.url = '<video class="video" width="1440" height="800"  poster="'+imgServerDomain+'/images/video/2D/smart-manager_first.jpg"><source src="'+imgServerDomain+'/images/video/2D/smart-manager.mp4" type="video/mp4"></video>';
        perfor2.poster = imgServerDomain+'/images/video/2D/smart-manager_first.jpg';
        perfor2.source = imgServerDomain+'/images/video/2D/smart-manager.mp4';
        perfor2.width = 1440;
        perfor2.height = 800;





        videoArr.push(spen1);
        videoArr.push(design1);
        videoArr.push(pay1);
        videoArr.push(charge1);
        videoArr.push(camera1);
        videoArr.push(enter1);
        videoArr.push(perfor1);

        videoArr.push(spen2);
        videoArr.push(design2);
        videoArr.push(pay2);
        videoArr.push(charge2);
        videoArr.push(camera2);
        videoArr.push(enter2);
        videoArr.push(perfor2);


        videoArr.push(spen3);
        videoArr.push(camera3);
        videoArr.push(enter3);

        videoArr.push(spen4);






        var total = videoArr.length;


        for (var i=0;i<total;i++){
            var obj = videoArr[i];
            obj.init();
        }



        //var loadCount = 0;
        //var timer = setInterval(function(){
        //
        //    var obj = videoArr[loadCount];
        //    obj.append();
        //    loadCount++;
        //    if(total == loadCount){
        //        clearInterval(timer);
        //    }
        //
        //}, 1000);

    }




    //$(stepVideo).bind('loadedmetadata', function(e) {
    //    console.log(e);
    //    stepVideo.play();
    //});
    //
    //design1.obj.addClass('ie8');
    //charge1.obj.addClass('ie8');
    //camera1.obj.addClass('ie8');
    //enter1.obj.addClass('ie8');
    //perfor1.obj.addClass('ie8');
    //
    //design1.obj.addClass('im');
    //charge1.obj.addClass('im');
    //camera1.obj.addClass('im');
    //enter1.obj.addClass('im');
    //perfor1.obj.addClass('im');


    var exports = {

        init: function(p){
            parents = p;


        },

        start: function(step){
            if(!ie8){
                //console.log("start:"+step);
                for (var i=0;i<total;i++){
                    var obj = videoArr[i];
                    obj.start(step);
                }

            }
        },

        end: function(step){
            if(!ie8){
                //console.log("end:"+step);
                for (var i=0;i<total;i++){
                    var obj = videoArr[i];
                    obj.end(step);




                }





            }



        }




    };


    return exports;


});













