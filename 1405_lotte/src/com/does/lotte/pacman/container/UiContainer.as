package com.does.lotte.pacman.container {
	import com.does.lotte.pacman.ui.GameUI;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class UiContainer extends Sprite {
		public var gameUI : GameUI;
		private var gameContainer : GameContainer;

		public function UiContainer() {
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

		public function initUI() : void {
			gameUI = new GameUI();
			addChild(gameUI);
			gameContainer.setUiContainer(this);
		}

		public function reset() : void {
			gameUI.reset();
		}

		public function startGame() : void {
			gameUI.startGame();
		}

		public function setGameContainer(gameContainer : GameContainer) : void {
			this.gameContainer = gameContainer;
		}
	}
}
