package com.does.lotte.pacman.ui {
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.object.character.Character;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class LifeView extends Sprite {
		public var life1 : Sprite;
		public var life2 : Sprite;
		public var life3 : Sprite;

		public function LifeView() {
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			init();
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			start();
		}

		private function initRemoveStage(event : Event) : void {
			stage.removeEventListener(GameEvent.MINUS_LIFE, minusLifeListener);
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function init() : void {
		}

		private function start() : void {
			stage.addEventListener(GameEvent.MINUS_LIFE, minusLifeListener);
		}

		private function minusLifeListener(event : GameEvent) : void {
			trace('Character.life: ' + (Character.life));

			var life : Sprite = this["life" + Character.life] as Sprite;

			life.alpha = 0.3;
		}

		public function reset() : void {
			// Character.life = 3;
			// for (var i : int = 0;i < 3;i++) {
			// var life : Sprite = this["life" + (i + 1)] as Sprite;
			// life.alpha = 1;
			// }
		}
	}
}
