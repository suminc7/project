package com.does.lotte.pacman.steps {
	import com.does.lotte.abstract.InOutMotion;
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.events.InOutMotionEvent;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.global.GameData;
	import com.does.lotte.global.Score;
	import com.does.lotte.global.Tracking;
	import com.framework.math.Rnd;
	import com.greensock.TweenMax;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Strong;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author chaesumin
	 */
	public class Roulette extends InOutMotion {
		public var rouletteScore : RouletteScore;
		public var mc : Sprite;
		public var nextBtn : Sprite;
		public var btn : Sprite;
		public var roul : Sprite;
		private var isBtnDown : Boolean;
		private var Degrees : Number;
		private const maxDeg : int = 37;
		private const minDeg : int = -20;
		private var dragPlay : Boolean;
		private var isStart : Boolean;

		public function Roulette() {
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			init();
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			start();
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			stage.removeEventListener(StepEvent.ROULETTE_FIRST, rouletteFirst);
			removeEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}

		private function init() : void {
			nextBtn = mc["nextBtn"];

			MovieClip(mc["stageMc"]).gotoAndStop(GameData.currentStep);
			MovieClip(mc["txt"]).gotoAndStop(GameData.currentStep);
			
			if(GameData.currentStep == 1){
				nextBtn.visible = false;
			}
		}

		private function start() : void {
			addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
			stage.addEventListener(StepEvent.ROULETTE_FIRST, rouletteFirst);
		}

		private function rouletteFirst(event : StepEvent) : void {
			isBtnDown = false;
			TweenMax.to(btn, .3, {rotation:minDeg, ease:Strong.easeOut});
		}

		private function btnDown(event : MouseEvent) : void {
			isBtnDown = true;

			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);

			SoundController.instance(root).rouletteClick();
		}

		private function mouseUp(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);

			if (isBtnDown && Degrees > maxDeg - 7) {
				TweenMax.to(btn, .3, {rotation:maxDeg, ease:Strong.easeOut, onComplete:onComplete});
			}
			if (Degrees < maxDeg - 7) {
				TweenMax.to(btn, .3, {rotation:minDeg, ease:Strong.easeOut, onComplete:onComplete2});
			}
			function onComplete2() : void {
				dragPlay = false;
			}
			function onComplete() : void {
				
				rotationStart();
				
//				if (GameData.currentStep == 1) {
//					rotationStart();
//				} else {
//					dispatchEvent(new StepEvent(StepEvent.INVITE_FRIEND, true));
//					isBtnDown = false;
//				}
			}
		}

		private function mouseMove(event : MouseEvent) : void {
			// find out mouse coordinates to find out the angle
			var cy : Number = mouseY - btn.y;
			var cx : Number = mouseX - btn.x;
			// find out the angle
			var Radians : Number = Math.atan2(cy, cx);
			// convert to degrees to rotate
			Degrees = Radians * 180 / Math.PI;
			// rotate

			if (Degrees > -10) {
				if (!dragPlay) {
					dragPlay = true;
					SoundController.instance(root).rouletteDrag();
				}
			}

			if (Degrees < minDeg) {
				Degrees = minDeg;
			} else if (Degrees > maxDeg) {
				Degrees = maxDeg;
			}

			btn.rotation = Degrees;
		}

		private function outComplete(event : InOutMotionEvent) : void {
			dispatchEvent(new StepEvent(StepEvent.STAGE_SCORE, true));
		}

		override protected function initInMotionScriptComplete() : void {
			nextBtn.buttonMode = true;
			nextBtn.addEventListener(MouseEvent.CLICK, nextBtnClick);

			btn.buttonMode = true;
			btn.addEventListener(MouseEvent.MOUSE_DOWN, btnDown);

			BtnController.down(MovieClip(nextBtn));
		}

		private function nextBtnClick(event : MouseEvent) : void {
			if(isStart){
				return;
			}
			
			Tracking.track("click", "Game_St"+GameData.currentStep+"_chance_cancel");
			
			nextBtn.buttonMode = false;
			nextBtn.removeEventListener(MouseEvent.CLICK, nextBtnClick);

			out();
		}

		public function rotationStart() : void {
			
			isStart = true;
			
			SoundController.instance(root).rouletteRotation();

			TweenMax.to(btn, .3, {rotation:minDeg, ease:Strong.easeOut});
			btn.buttonMode = false;
			btn.removeEventListener(MouseEvent.MOUSE_DOWN, btnDown);

			var myTime : int = 3600;

			var numRnd : int = Rnd.integer(1, 341);
			var min : int;
			var max : int;

			// ExternalInterface.call("console.log", "rnd:" + numRnd);

			if (0 < numRnd && numRnd <= 80) {
				min = 135;
				max = 180;
				Score.myRoulette = 4;
				trace('failed');
			} else if (80 < numRnd && numRnd <= 140) {
				min = 315;
				max = 360;
				Score.myRoulette = 8;
				trace('+1000');
			} else if (140 < numRnd && numRnd <= 200) {
				min = 0;
				max = 45;
				Score.myRoulette = 1;
				trace('+3000');
			} else if (200 < numRnd && numRnd <= 250) {
				min = 180;
				max = 225;
				Score.myRoulette = 5;
				trace('+5000');
			} else if (250 < numRnd && numRnd <= 290) {
				min = 270;
				max = 315;
				Score.myRoulette = 7;
				trace('+7000');
			} else if (290 < numRnd && numRnd <= 315) {
				min = 45;
				max = 90;
				Score.myRoulette = 2;
				trace('+10000');
			} else if (315 < numRnd && numRnd <= 330) {
				min = 225;
				max = 270;
				Score.myRoulette = 6;
				trace('x2');
			} else if (330 < numRnd && numRnd <= 340) {
				min = 90;
				max = 135;
				Score.myRoulette = 3;
				trace('x3');
			}

			var rnd : int = Rnd.integer(min, max);
			var r : int = (3600 + rnd);
			var time : Number = r / 1000;

			TweenMax.to(roul, 1.8, {rotation:myTime, ease:Quart.easeIn});
			TweenMax.to(roul, time, {rotation:roul.rotation + r, ease:Strong.easeOut, delay:1.8, onComplete:onComplete});

			function onComplete() : void {
				rouletteScore = new RouletteScore();
				addChild(rouletteScore);
			}
		}
	}
}
