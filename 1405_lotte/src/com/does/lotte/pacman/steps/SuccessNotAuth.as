package com.does.lotte.pacman.steps {
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class SuccessNotAuth extends Sprite {
		public function SuccessNotAuth() {
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
		}

		private function start() : void {
		}
	}
}
