package com.does.lotte.pacman.container {
	import com.does.lotte.types.KeyType;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.pacman.steps.HowToControl;
	import com.does.lotte.global.GameData;
	import com.does.lotte.interfaces.IMap;
	import com.does.lotte.object.character.Character;
	import com.does.lotte.object.maps.Map1;
	import com.does.lotte.object.maps.Map2;
	import com.does.lotte.object.maps.Map3;
	import com.does.lotte.object.maps.MapData;
	import com.does.lotte.object.monster.Monster1;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;


	/**
	 * @author chaesumin
	 */
	public class GameContainer extends Sprite {
		private var map : IMap;
		private var char : Character;
		private var moster : Monster1;
		private var moster2 : Monster1;
		private var moster3 : Monster1;
		private var uiContainer : UiContainer;
		private var howtoControl : HowToControl;

		public function GameContainer() {
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
			// stage.addEventListener(GameEvent.NEXT_STAGE, nextStageListener);
		}

		public function setGame() : void {
			while (numChildren) {
				removeChildAt(0);
			}

			uiContainer.reset();

			trace('GameData.currentStep: ' + (GameData.currentStep));
			if (GameData.currentStep == 1) {
				initGame1();
			} else if (GameData.currentStep == 2) {
				initGame2();
			} else if (GameData.currentStep == 3) {
				initGame3();
			}
		}

		public function initGame3() : void {
			MapData.setTile(Map3.tx, Map3.ty);

			map = new Map3();
			map.setHeartView(uiContainer.gameUI.heartView);
			map.setScoreView(uiContainer.gameUI.scoreView);
			map.setFriendsView(uiContainer.gameUI.friendsView);
			map.setTimerView(uiContainer.gameUI.timerView);
			addChildAt(DisplayObject(map), 0);

			char = new Character(map);
			char.setPosition(8, 3, 0);
			char.frameCheck(KeyType.RIGHT);
			map.setCharacter(char);

			moster = new Monster1(map, char);
			moster.setPosition(17, 5, 0);
			addChild(moster);

			moster2 = new Monster1(map, char);
			moster2.setPosition(17, 11, 0);
			addChild(moster2);

			moster3 = new Monster1(map, char);
			moster3.setPosition(9, 12, 0);
			addChild(moster3);

			addChild(char);
		}

		public function initGame2() : void {
			MapData.setTile(Map2.tx, Map2.ty);

			map = new Map2();
			map.setHeartView(uiContainer.gameUI.heartView);
			map.setScoreView(uiContainer.gameUI.scoreView);
			map.setFriendsView(uiContainer.gameUI.friendsView);
			map.setTimerView(uiContainer.gameUI.timerView);
			addChildAt(DisplayObject(map), 0);

			char = new Character(map);
			char.setPosition(12, 1, 0);
			char.frameCheck(KeyType.RIGHT);
			map.setCharacter(char);

			moster = new Monster1(map, char);
			moster.setPosition(16, 5, 0);
			addChild(moster);

			moster2 = new Monster1(map, char);
			moster2.setPosition(15, 11, 0);
			addChild(moster2);

			addChild(char);
		}

		public function initGame1() : void {
			MapData.setTile(Map1.tx, Map1.ty);

			map = new Map1();
			map.setHeartView(uiContainer.gameUI.heartView);
			map.setScoreView(uiContainer.gameUI.scoreView);
			map.setFriendsView(uiContainer.gameUI.friendsView);
			map.setTimerView(uiContainer.gameUI.timerView);
			addChildAt(DisplayObject(map), 0);

			char = new Character(map);
			char.setPosition(2, 8, 0);
			char.frameCheck(KeyType.UP);
			map.setCharacter(char);

			moster = new Monster1(map, char);
			moster.setPosition(16, 10, 0);
			addChild(moster);

			moster2 = new Monster1(map, char);
			moster2.setPosition(16, 15, 0);
			addChild(moster2);
			

			addChild(char);
		}

		public function startGame() : void {
			if (char) char.startGame();
			if (moster) moster.startGame();
			if (moster2) moster2.startGame();
			if (moster3) moster3.startGame();
			if (map) map.startGame();
			
			initHowToControl();
		}

		private function initHowToControl() : void {
			howtoControl = new HowToControl();
			howtoControl.addEventListener(GameEvent.FINISHED_HOWTOCONTROL, finishedHowToControl);
			addChild(howtoControl);
		}

		private function finishedHowToControl(event : GameEvent) : void {
			howtoControl.removeEventListener(GameEvent.FINISHED_HOWTOCONTROL, finishedHowToControl);
			removeChild(howtoControl);
		}

		public function setUiContainer(uiContainer : UiContainer) : void {
			this.uiContainer = uiContainer;
		}

		public function reset() : void {
			Character.life = 3;
		}
	}
}
