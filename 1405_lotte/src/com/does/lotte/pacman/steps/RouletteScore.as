package com.does.lotte.pacman.steps {
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.global.Score;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author chaesumin
	 */
	public class RouletteScore extends Sprite {
		public var scoreBtn : Sprite;
		public var s1 : MovieClip;
		public var s2 : MovieClip;
		public var s3 : MovieClip;
		public var s4 : MovieClip;
		public var s5 : MovieClip;
		public var s6 : MovieClip;
		public var s7 : MovieClip;
		public var s8 : MovieClip;

		public function RouletteScore() {
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
		}

		private function init() : void {
			for (var i : int = 1;i <= 8;i++) {
				var score : MovieClip = this["s" + i] as MovieClip;
				score.gotoAndStop(1);
				score.visible = false;
			}

			dispatchEvent(new StepEvent(StepEvent.STAGE_SCORE, true));
		}

		private function start() : void {
			// addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);

			var score : MovieClip = this["s" + Score.myRoulette] as MovieClip;
			score.play();
			score.visible = true;

			scoreBtn.buttonMode = true;
			scoreBtn.addEventListener(MouseEvent.CLICK, scoreBtnClick);

			BtnController.over(MovieClip(scoreBtn));

			if (Score.myRoulette == 4) {
				SoundController.instance(root).rouletteFailed();
			}else{
				SoundController.instance(root).rouletteSuccess();
			}
		}

		// private function outComplete(event : InOutMotionEvent) : void {
		// dispatchEvent(new StepEvent(StepEvent.STAGE_SCORE, true));
		// }
		private function scoreBtnClick(event : MouseEvent) : void {
			dispatchEvent(new StepEvent(StepEvent.STAGE_SCORE, true));
		}
		// override protected function initInMotionScriptComplete() : void {
		// scoreBtn.buttonMode = true;
		// scoreBtn.addEventListener(MouseEvent.CLICK, scoreBtnClick);
		// }

		// private function scoreBtnClick(event : MouseEvent) : void {
		// out();
		// }
	}
}
