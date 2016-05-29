package com.does.lotte.pacman.steps {
	import com.does.lotte.events.GameEvent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class HowToControl extends MovieClip {
		public function HowToControl() {
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
			addFrameScript(totalFrames - 1, finished);
		}

		private function finished() : void {
			dispatchEvent(new GameEvent(GameEvent.FINISHED_HOWTOCONTROL));
		}
	}
}
