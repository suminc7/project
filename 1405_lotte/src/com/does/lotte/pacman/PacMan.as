package com.does.lotte.pacman {
	import flash.system.Security;
	import com.chargedweb.utils.ResourceMonitor;
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.global.User;
	import com.does.lotte.pacman.container.GameContainer;
	import com.does.lotte.pacman.container.StepContainer;
	import com.does.lotte.pacman.container.UiContainer;
	import com.does.lotte.pacman.steps.EventSubmit;
	import com.does.lotte.pacman.steps.Main;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.external.ExternalInterface;
	import flash.ui.Keyboard;

	/**
	 * @author chaesumin
	 */
	public class PacMan extends Sprite {
		private var gameContainer : GameContainer;
		private var stepContainer : StepContainer;
		private var uiContainer : UiContainer;
		private var main : Main;
		public var mc : Sprite;
		public var ui : Sprite;
		private var eventSubmit : EventSubmit;

		public function PacMan() {
			Security.allowDomain("enriching.co.kr");
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
			
			// initGame(null);
		}

		private function keyDown(event : KeyboardEvent) : void {
			if (event.keyCode == Keyboard.UP) {
				dispatchEvent(new GameEvent(GameEvent.KEY_UP, true));
			} else if (event.keyCode == Keyboard.DOWN) {
				dispatchEvent(new GameEvent(GameEvent.KEY_DOWN, true));
			} else if (event.keyCode == Keyboard.LEFT) {
				dispatchEvent(new GameEvent(GameEvent.KEY_LEFT, true));
			} else if (event.keyCode == Keyboard.RIGHT) {
				dispatchEvent(new GameEvent(GameEvent.KEY_RIGHT, true));
			}
		}

		private function initMain() : void {
			// ExternalInterface.call("console.log", "main:" + User.getUserProfile());
			main = new Main();
			main.addEventListener(GameEvent.INIT_GAME, initGame);
			mc.addChild(main);

			// SendData.loadTest();
			
			// ExternalInterface.call("GAME.insertScore", "111111", "222222", "333333", "444444");
		}

		private function removeMain() : void {
			if (main) {
				main.removeEventListener(GameEvent.INIT_GAME, initGame);
				mc.removeChild(main);
				main = null;
			}
		}

		private function initGame(event : GameEvent) : void {
			removeMain();

			gameContainer = new GameContainer();
			stepContainer = new StepContainer();
			uiContainer = new UiContainer();

			gameContainer.y = 60;

			stepContainer.setUiContainer(uiContainer);
			stepContainer.setGameContainer(gameContainer);
			uiContainer.setGameContainer(gameContainer);

			mc.addChild(gameContainer);
			mc.addChild(stepContainer);
			ui.addChild(uiContainer);

			eventSubmit = new EventSubmit();
			mc.addChild(eventSubmit);

//			initMonitor();
		}

		private function initMonitor() : void {
			var rm : ResourceMonitor = new ResourceMonitor(true, true, 50);
			rm.x = 890;
			rm.y = 540;
			addChild(rm);
			rm.showFpsAVG = true;
			rm.showGrid = true;
			rm.graphStyle = {width:100, height:70, gridColor:0xFFFFFF, bgColor:0x000000, lineColor:0xFFCC00, lineSize:2};
			rm.monitor();
		}

		private function start() : void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);

			stage.stageFocusRect = false;

			if (ExternalInterface.objectID) {
				User.setData(initMain);
			} else {
				initMain();
			}
			SoundController.instance(root);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyListener);
		}

		private function keyListener(event : KeyboardEvent) : void {
			if (event.keyCode == Keyboard.N && event.shiftKey) {
				dispatchEvent(new GameEvent(GameEvent.SUCCESS, true));
			}
		}
	}
}
