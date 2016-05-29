package com.does.lotte.pacman.ui {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author chaesumin
	 */
	public class FriendsView extends Sprite {
		public var txt : TextField;

		public function FriendsView() {
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
		}

		public function setFriend(str : String) : void {
			txt.text = str;
		}
	}
}
