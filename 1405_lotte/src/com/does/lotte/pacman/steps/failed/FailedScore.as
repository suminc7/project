package com.does.lotte.pacman.steps.failed {
	import com.does.lotte.global.Score;
	import com.framework.math.MathUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author chaesumin
	 */
	public class FailedScore extends Sprite {
		public var txt : TextField;

		public function FailedScore() {
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
			txt.autoSize = TextFieldAutoSize.CENTER;
		}

		private function start() : void {
			txt.text = MathUtils.putComma(Score.totalScore);
		}
	}
}
