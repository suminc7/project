package com.does.lotte.object.maps {
	import com.does.lotte.events.GameEvent;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class Friends extends MovieClip {
		public function Friends() {
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
			addFrameScript(totalFrames - 1, dispatch);
		}

		private function dispatch() : void {
			stop();
			dispatchEvent(new GameEvent(GameEvent.EAT_FRIEND_END, true));
		}

		public function playFriend() : void {
			if (currentFrame == 1) {
				play();
				dispatchEvent(new GameEvent(GameEvent.EAT_FRIEND, true));
			}
		}
	}
}
