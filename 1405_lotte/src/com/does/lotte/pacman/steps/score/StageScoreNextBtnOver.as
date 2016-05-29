package com.does.lotte.pacman.steps.score {
	import com.does.lotte.global.GameData;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class StageScoreNextBtnOver extends MovieClip {
		public function StageScoreNextBtnOver() {
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
			stop();
		}

		private function start() : void {
			if (GameData.currentStep == 3) {
				gotoAndStop(2);
			}
		}
	}
}
