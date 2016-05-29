package com.does.lotte.pacman.ui {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class ScoreView extends Sprite {
		public var txt : TextField;

		public function ScoreView() {
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
			setScore("0");
			
			txt.autoSize = TextFieldAutoSize.CENTER;
		}

		private function start() : void {
		}

		public function setScore(num : String) : void {
			txt.text = String(num);
		}
	}
}
