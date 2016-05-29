package com.does.lotte.pacman.steps {
	import com.does.lotte.abstract.InOutMotion;
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.events.InOutMotionEvent;
	import com.does.lotte.global.GameData;
	import com.does.lotte.global.Score;
	import com.does.lotte.global.Tracking;
	import com.framework.math.MathUtils;
	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author chaesumin
	 */
	public class StageScore extends InOutMotion {
		public var nextBtn : Sprite;
		//
		public var heart : Sprite;
		public var friend : Sprite;
		public var time : Sprite;
		public var roulette : Sprite;
		public var plus : Sprite;
		public var stageTotal : Sprite;
		public var stageMc : MovieClip;
		public var mc : Sprite;
		public var back : Sprite;
		//
		protected var objNum : Object = {heartNum:0, friendNum:0, timeNum:0, rouletteNum:0, totalNum:0};
		protected var objScore : Object = {heartScore:0, friendScore:0, timeScore:0, rouletteScore:0, totalScore:0};
		protected var rightScore : Object = {s1Score:0, s2Score:0, s3Score:0, s4Score:0};
		protected var stageTotalScore : Object = {total:0};
		private var currentStepScore : int;

		public function StageScore() {
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
			removeEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}

		private function init() : void {
			heart = mc["heart"];
			friend = mc["friend"];
			time = mc["time"];
			roulette = mc["roulette"];
			plus = mc["plus"];
			stageTotal = mc["stageTotal"];
			stageMc = back["stageMc"];

			stageMc.gotoAndStop(GameData.currentStep);

			TextField(friend["multi"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(friend["sum"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(friend["multi"]).text = "x0";
			TextField(friend["sum"]).text = "0";
			TextField(heart["multi"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(heart["sum"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(heart["multi"]).text = "x0";
			TextField(heart["sum"]).text = "0";
			TextField(time["multi"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(time["sum"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(time["multi"]).text = "x0";
			TextField(time["sum"]).text = "0";
			TextField(roulette["sum"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(roulette["sum"]).text = "0";
			TextField(plus["sum"]).autoSize = TextFieldAutoSize.RIGHT;
			TextField(plus["sum"]).text = "0";

			TextField(stageTotal["s1"]).text = "0";
			TextField(stageTotal["s2"]).text = "0";
			TextField(stageTotal["s3"]).text = "0";

			if (GameData.currentStep == 1) {
			} else if (GameData.currentStep == 2) {
				TextField(stageTotal["s1"]).text = MathUtils.putComma(Score.stage1Score);
			} else if (GameData.currentStep == 3) {
				TextField(stageTotal["s1"]).text = MathUtils.putComma(Score.stage1Score);
				TextField(stageTotal["s2"]).text = MathUtils.putComma(Score.stage2Score);
			}

			var totalScore : int = Score.beforeTotalScore;
			for (var i : int = 0;i < 7;i++) {
				var str : String = MathUtils.numToString(totalScore, 7);
				var s : String = str.substr(i, 1);
				TextField(stageTotal["t" + i]).text = s;
			}
		}

		private function start() : void {
			currentStepScore = Score.currentStepScore;
			addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}

		private function initStageTotalScore() : void {
			var num : int = Score.totalScore;
			TweenMax.to(stageTotalScore, 20, {total:num, onUpdate:onUpdate, useFrames:true});

			function onUpdate() : void {
				var num : int = stageTotalScore["total"];

				for (var i : int = 0;i < 7;i++) {
					var str : String = MathUtils.numToString(num, 7);
					var s : String = str.substr(i, 1);
					TextField(stageTotal["t" + i]).text = s;
				}

				scoreStartSound();
			}
		}

		private function initRightTotal() : void {
			if (GameData.currentStep == 1) {
				initRightTotalScore1();
			} else if (GameData.currentStep == 2) {
				initRightTotalScore2();
			} else if (GameData.currentStep == 3) {
				initRightTotalScore3();
			}
		}

		private function initRightTotalScore1() : void {
			var num : int = currentStepScore;
			TweenMax.to(rightScore, 20, {s1Score:num, onUpdate:onUpdate, useFrames:true, onComplete:initStageTotalScore});

			function onUpdate() : void {
				var num : int = rightScore["s1Score"];
				TextField(stageTotal["s1"]).text = MathUtils.putComma(num);

				scoreStartSound();
			}
		}

		private function initRightTotalScore2() : void {
			var num : int = currentStepScore;
			TweenMax.to(rightScore, 20, {s2Score:num, onUpdate:onUpdate, useFrames:true, onComplete:initStageTotalScore});

			function onUpdate() : void {
				var num : int = rightScore["s2Score"];
				TextField(stageTotal["s2"]).text = MathUtils.putComma(num);

				scoreStartSound();
			}
		}

		private function initRightTotalScore3() : void {
			var num : int = currentStepScore;
			TweenMax.to(rightScore, 20, {s3Score:num, onUpdate:onUpdate, useFrames:true, onComplete:initStageTotalScore});

			function onUpdate() : void {
				var num : int = rightScore["s3Score"];
				TextField(stageTotal["s3"]).text = MathUtils.putComma(num);

				scoreStartSound();
			}
		}

		private function initStageScore() : void {
			var num : int = currentStepScore;
			trace('currentStepScore: ' + (currentStepScore));
			TweenMax.to(objScore, 20, {totalScore:num, onUpdate:onUpdate2, useFrames:true, onComplete:initRightTotal});

			function onUpdate2() : void {
				var num : int = objScore["totalScore"];
				TextField(plus["sum"]).text = MathUtils.putComma(num);

				scoreStartSound();
			}
		}

		private function initRoulette() : void {
			TextField(roulette["sum"]).text = Score.getRouletteText();

			TweenMax.delayedCall(0.5, initStageScore);
		}

		private function initTime() : void {
			var num : Number = Score.myTime;
			TweenMax.to(objNum, 20, {timeNum:num, onUpdate:onUpdate1, useFrames:true});
			TweenMax.to(objScore, 20, {timeScore:num, onUpdate:onUpdate2, useFrames:true, delay:10, onComplete:initRoulette});

			function onUpdate1() : void {
				var num : Number = objNum["timeNum"];
				TextField(time["multi"]).text = "x" + Math.round(num * 100) / 100;

				scoreStartSound();
			}

			function onUpdate2() : void {
				var num : Number = objScore["timeScore"];
				TextField(time["sum"]).text = MathUtils.putComma(Math.round(num * Score.timeScore) * 100 / 100);

				scoreStartSound();
			}
		}

		private function initFriend() : void {
			var num : int = Score.myFriend;
			TweenMax.to(objNum, num, {friendNum:num, onUpdate:onUpdate1, useFrames:true});
			TweenMax.to(objScore, num, {friendScore:num, onUpdate:onUpdate2, useFrames:true, delay:num, onComplete:initTime});

			function onUpdate1() : void {
				var num : int = objNum["friendNum"];
				TextField(friend["multi"]).text = "x" + num;

				scoreStartSound();
			}

			function onUpdate2() : void {
				var num : int = objScore["friendScore"];
				TextField(friend["sum"]).text = MathUtils.putComma(num * Score.friendScore);

				scoreStartSound();
			}
		}

		private function initHeart() : void {
			var num : int = Score.myHeart;
			TweenMax.to(objNum, 20, {heartNum:num, onUpdate:onUpdate1, useFrames:true});
			TweenMax.to(objScore, 20, {heartScore:num, onUpdate:onUpdate2, useFrames:true, delay:10, onComplete:initFriend});

			function onUpdate1() : void {
				var num : int = objNum["heartNum"];
				TextField(heart["multi"]).text = "x" + num;
				scoreStartSound();
			}

			function onUpdate2() : void {
				var num : int = objScore["heartScore"];
				TextField(heart["sum"]).text = MathUtils.putComma(num * Score.heartScore);

				scoreStartSound();
			}
		}

		override protected function initInMotionScriptComplete() : void {
			nextBtn.buttonMode = true;
			nextBtn.addEventListener(MouseEvent.CLICK, nextBtnClick);

			BtnController.down(MovieClip(nextBtn));

			TweenMax.delayedCall(0, initHeart);
		}

		private function scoreStartSound() : void {
			SoundController.instance(root).scoreStart();
		}

		private function nextBtnClick(event : MouseEvent) : void {
			nextBtn.buttonMode = false;
			nextBtn.removeEventListener(MouseEvent.CLICK, nextBtnClick);

			Tracking.track("click", "Game_St" + GameData.currentStep + "_to_St" + (GameData.currentStep + 1));
			TweenMax.killTweensOf(objNum);
			TweenMax.killTweensOf(objScore);
			TweenMax.killTweensOf(rightScore);
			TweenMax.killTweensOf(stageTotalScore);
			
			
			SendData.check(setScoreComplete);
			
		}

		private function setScoreComplete() : void {

			out();

		}

		private function outComplete(event : InOutMotionEvent) : void {
			dispatchEvent(new GameEvent(GameEvent.NEXT_STAGE, true));
		}
	}
}
