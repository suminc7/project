var mlPingPong = {

    ball : function() {

        createjs.Sound.registerSound("assets/pong/sound/pong.mp3", "hit");
        createjs.Sound.registerSound("assets/pong/sound/pongdie.mp3", "die");

        var canvas = document.getElementById('canvas'),
            z = document.outerWidth || document.documentElement.clientWidth || document.body.clientWidth,
            zz = document.innerHeight || document.documentElement.clientHeight || document.body.clientWidth,
            ctx,
            WIDTH = 650,
            HEIGHT = 488,
            dx = 5,
            dy = 1,
            doy = 20,
            dty = 20,
            impact,
            flag = 0,
            scores = {playerOneScore : 0, playerTwoScore : 0},
            aKey = true,
            keys = [],
            pox = 40,
            bar1 = {x:25, y:20, height:10, width:WIDTH-50},
            bar2 = {x:25, y:HEIGHT-30, height:10, width:WIDTH-50},
            pow = 10,//pad wid
            poh = 70,//pad height
            fpoy = HEIGHT/2-poh/2,
            poy = fpoy,
            ptx = WIDTH - 50,
            fpty = HEIGHT/2-poh/2,
            pty = fpty,
            cw = 6,
            x = pox + pow + cw+2, /* Starting Xposition */
            y = HEIGHT/2, /* Starting Yposition */
            a,
            mouse = {},
            diffOffset = 5,
            mx,
            my,
            c = 0,
            oty = (bar1.y + bar1.height) + poh/ 2,
            oby = bar2.y - poh/ 2,
            rdy = 1.0,
            ny = 0,
            offsetY = 5,
            isUser = true,
            pongInterval;


        function circle(x,y,r) {
            //ctx.beginPath();
            //ctx.arc(x, y, r, 0, Math.PI*2, true);
            //ctx.fill();

            ctx.beginPath();
            ctx.rect(x-r/2,y-r/2,r*2,r*2);
            ctx.closePath();
            ctx.fill();

        }

        function rect(x,y,w,h) {
            ctx.beginPath();
            ctx.rect(x,y,w,h);
            ctx.closePath();
            ctx.fill();

        }

        function p1Rect(pox,poy,pow,poh) {
            ctx.beginPath();
            ctx.rect(pox,poy,pow,poh);
            ctx.closePath();
            ctx.fill();
        }

        function p1Score(ox,oy) {
            ctx.textAlign="right";
            ctx.fillStyle = 'rgba(255,255,255,1)';
            ctx.font = '50px squarefontregular';
            ctx.fillText(scores.playerOneScore,ox,oy);
        }

        function p2Rect(ptx,pty,pow,poh) {
            //console.log(ptx,pty,pow,poh)
            ctx.beginPath();
            ctx.rect(ptx,pty,pow,poh);
            ctx.closePath();
            ctx.fill();
        }

        function p2Score(tx,ty) {
            ctx.textAlign="left";
            ctx.fillStyle = 'rgba(255,255,255,1)';
            ctx.font = '50px squarefontregular';
            ctx.fillText(scores.playerTwoScore,tx,ty);
        }

        function clear() {
            ctx.clearRect(0, 0, WIDTH, HEIGHT);
        }

        $(document).bind('keydown', function(e){
            switch(e.which) {
                case 38: // left
                    ny = -offsetY;
                    break;
                case 40: // right
                    ny = offsetY;
                    break;
                case 32: // right
                    if(flag == 0) {
                        flag = 1;
                    }
                    break;
                default: return;
            }
            e.preventDefault()
        });
        $(document).bind('keyup', function(e){
            switch(e.which) {
                case 38: // left
                    if(ny == -offsetY){
                        ny = 0;
                    }
                    break;
                case 40: // right
                    if(ny == offsetY){
                        ny = 0;
                    }
                    break;

                default: return;
            }
            e.preventDefault();


        });

        function checkCollision() {

            if(x < (WIDTH / 2)) {
                //left
                if(poy < y && y < poy + poh){//y+hei

                    if(-5 < (x - cw) - (pox + pow) && (x - cw) - (pox + pow) < 0){//x
                        c = 1;
                        impact = y - poy;
                        calibrateAngle(impact);
                        createjs.Sound.play("hit");
                        //diffOffset ai가 공을 따라가는 속도
                        diffOffset = 3 + Math.floor(Math.random() * 4);
                        console.log(diffOffset);
                    }
                }
            } else {
                //right
                if(pty < y && y < pty + poh){
                    if( -5 < ptx - (x + cw) && ptx - (x + cw) < 0 ){
                        c = 1;
                        impact = y - pty;
                        calibrateAngle(impact);
                        createjs.Sound.play("hit");
                    }
                }
            }

        }

        function calibrateAngle(impact) {
            //console.log(impact);
            //impact = 0~60
            // -9 ~ 9

            var ddy = Math.floor(impact / 2 - 15);
            if(ddy == 0){
                //0 이면 bar 중앙에 맞았을때.. -5 ~ 5
                ddy = -5 + Math.random() * 10;
            }
            dy = ddy;

        }

        function init() {
            ctx = canvas.getContext("2d");
            return setInterval(draw, 15);
        }

        function addScore() {
            /* End point if off the edge of screen */
            if (x > WIDTH) {
                scores.playerOneScore++;

                if(scores.playerOneScore == 3){
                    gameFinished(300);
                    clearInterval(pongInterval);
                }


                flag = 0;
                dy = 1;


                pox = 50;
                poy = fpoy;
                pty = fpty;

                isUser = true;
                createjs.Sound.play("die");
            }
            if (x < 0) {
                scores.playerTwoScore++;

                if(scores.playerTwoScore == 3){
                    gameFinished(300);
                    clearInterval(pongInterval);
                }


                flag = 0;
                dx = -dx;
                dy = 1;

                ptx = WIDTH - 50;
                poy = fpoy;
                pty = fpty;

                isUser = false;
                createjs.Sound.play("die");
            }
        }

        function draw() {
            clear();


            ctx.fillStyle = '#000';
            rect(0,0,WIDTH,HEIGHT);

            ctx.setLineDash([12,12]);
            ctx.strokeStyle = 'rgba(250,250,250,0.9)';
            ctx.lineWidth = 4;
            ctx.beginPath();
            ctx.moveTo(WIDTH/2,35);
            ctx.lineTo(WIDTH/2,HEIGHT-30);
            ctx.stroke();
            ctx.closePath();



            ctx.fillStyle = 'rgba(255,255,255,1)';
            ctx.strokeStyle = 'rgba(255,255,255,1)';
            p1Rect(pox,poy,pow,poh);
            p2Rect(ptx,pty,pow,poh);
            ctx.strokeStyle = '#fff';



            p1Score((WIDTH/2) - 30,110);
            p2Score((WIDTH/2) + 30,110);
            a == 1 ? ctx.fillStyle = "rgba(254,254,254,1)" : ctx.fillStyle = "rgba(254,254,254,1)";
            circle(x, y, cw);

            //상단 하단 white bar
            ctx.fillStyle = '#ffffff';
            rect(bar1.x,bar1.y,bar1.width,bar1.height);
            rect(bar2.x,bar2.y,bar2.width,bar2.height);

            addScore();

            //p1Rect 위아래 이동 체크
            poy += ny;
            if(poy < oty - poh/2){
                poy = oty - poh/2;
            }else if(poy > oby - poh/2) {
                poy = oby - poh/2;
            }

            //ball 시작점
            if(flag == 0 && isUser){
                x = pox + pow + cw+2;
                y = poy+poh/2 - cw/2;
            }else if(flag == 0 && !isUser){
                x = ptx - cw - cw;
                y = pty+poh/2 - cw/2;
            }





            // p1 p2 충돌 체크, in checkCollision
            if(c == 1) {
                dx = -dx;
                c = 0;
            }

            if(flag == 0) {}
            //충돌시 축 변화
            if(flag == 1) {
                x += dx; y += dy*0.8;
                //console.log(dx, dy);
            }

            //ai의 증속과 감속
            if(flag == 1){
                var diff = pty - (y - poh/2);
                var offset = diffOffset;
                if (diff < 0 && diff < -offset) {
                    diff = -(offset+1);
                } else if (diff > 0 && diff > offset) {
                    diff = (offset+1);
                }
                pty -= diff;

                if(pty < oty - poh/2){
                    pty = oty - poh/2;
                }else if(pty > oby - poh/2) {
                    pty = oby - poh/2;
                }
            }else{
                //pty = my-poh/2;
            }


            flag != 0 ? checkCollision() : '';


            // 상단 하단 충돌 체크
            if(y + dy + cw > bar2.y || y + dy  <  bar1.y + bar1.height + cw) {
                dy = -dy;
                createjs.Sound.play("hit");
            }
        }

        // Track the position of mouse cursor
        function trackPosition(e) {
            //mx = mouse.x = e.layerX;
            //my = mouse.y = e.layerY;
            //
            ////top
            //if(my < oty){
            //    my = oty;
            //}
            //
            ////bottom
            //if(my > oby){
            //    my = oby;
            //}
            //
            //
            //poy = my - poh/2;
            //
            //if(flag == 0){
            //    //x = pox + pow + cw+2;
            //    y = my;
            //}
        }

        pongInterval = init();
        //window.addEventListener('keydown',onKeyDown,true);
        //window.addEventListener('keyup',onKeyUp,true);
        canvas.addEventListener("mousemove", trackPosition, true);
    }

};