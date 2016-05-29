package com.does.lotte.pacman.ui {
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class GameUI extends Sprite {
		public var heartView : HeartView;
		public var scoreView : ScoreView;
		public var friendsView : FriendsView;
		public var timerView : TimerView;
		public var lifeView : LifeView;

		public function GameUI() {
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

		public function reset() : void {
			timerView.reset();
			lifeView.reset();
		}

		public function startGame() : void {
		}
	}
}
