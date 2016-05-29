package com.does.lotte.pacman.container {
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.global.Score;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.global.GameData;
	import com.does.lotte.pacman.steps.Failed;
	import com.does.lotte.pacman.steps.HowToPlay;
	import com.does.lotte.pacman.steps.InviteFriends;
	import com.does.lotte.pacman.steps.Main;
	import com.does.lotte.pacman.steps.Roulette;
	import com.does.lotte.pacman.steps.StageCount;
	import com.does.lotte.pacman.steps.StageScore;
	import com.does.lotte.pacman.steps.SuccessAuth;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class StepContainer extends Sprite {
		private var uiContainer : UiContainer;
		private var gameContainer : GameContainer;
		private var friend : InviteFriends;
		private var roulette : Roulette;

		public function StepContainer() {
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
			stage.removeEventListener(GameEvent.SUCCESS, success);
			stage.removeEventListener(GameEvent.FAILED, failed);
			stage.removeEventListener(GameEvent.NEXT_STAGE, nextStageListener);
			removeEventListener(StepEvent.STAGE_COUNT, stageCountListener);
			removeEventListener(StepEvent.INVITE_FRIEND, inviteFriendListener);
			removeEventListener(StepEvent.START_GAME, startGameListener);
			removeEventListener(StepEvent.REPLAY, replayListener);
			removeEventListener(StepEvent.STAGE_SCORE, stageScoreListener);
			removeEventListener(StepEvent.ROULETTE_START, rouletteStartListener);
			removeEventListener(StepEvent.ROULETTE_FIRST, rouletteFirstListener);
			removeEventListener(StepEvent.MAIN, mainListener);
		}

		private function init() : void {
		}

		private function start() : void {
			stage.addEventListener(GameEvent.SUCCESS, success);
			stage.addEventListener(GameEvent.FAILED, failed);
			stage.addEventListener(GameEvent.NEXT_STAGE, nextStageListener);
			addEventListener(StepEvent.STAGE_COUNT, stageCountListener);
			addEventListener(StepEvent.INVITE_FRIEND, inviteFriendListener);
			addEventListener(StepEvent.START_GAME, startGameListener);
			addEventListener(StepEvent.REPLAY, replayListener);
			addEventListener(StepEvent.STAGE_SCORE, stageScoreListener);
			addEventListener(StepEvent.ROULETTE_START, rouletteStartListener);
			addEventListener(StepEvent.ROULETTE_FIRST, rouletteFirstListener);
			addEventListener(StepEvent.MAIN, mainListener);

			initHowToPlay();
			// initMissionComplete();
		}

		private function mainListener(event : StepEvent) : void {
			remove();
			uiContainer.reset();
			initMain();
		}

		/*
		 * 메인 동영상으로 이
		 */
		private function initMain() : void {
			var main : Main = new Main();
			addChild(main);
		}

		/*
		 * 친구 초대 사라지고 룰렛 돌리기 시작
		 */
		private function rouletteStartListener(event : StepEvent) : void {
			removeChild(friend);
			roulette.rotationStart();
		}

		private function rouletteFirstListener(event : StepEvent) : void {
			removeChild(friend);
		}

		private function stageScoreListener(event : StepEvent) : void {
			remove();
			initStageScore();
		}

		/*
		 * 점수보기
		 */
		private function initStageScore() : void {
			var score : StageScore = new StageScore();
			addChild(score);
		}

		/*
		 * 다시하기 : stage 1 로 변경후.
		 */
		private function replayListener(event : StepEvent) : void {
			GameData.replay();
			Score.reset();

			remove();
			uiContainer.reset();
			gameContainer.reset();
			initHowToPlay();
		}

		/*
		 * 4. 게임 스테이지 완료하면 다음 스테이지 배치후 카운트 시
		 */
		private function nextStageListener(event : GameEvent) : void {
			remove();

			if (GameData.currentStep == 3) {
				initMissionComplete();
			} else {
				GameData.nextStep();
				uiContainer.reset();
				gameContainer.setGame();
				initStageCount();
			}
		}

		/*
		 * 미션완
		 */
		private function initMissionComplete() : void {
			SoundController.instance(root).success();

			var complete : SuccessAuth = new SuccessAuth();
			addChild(complete);
		}

		/*
		 * 스테이지 완료시 마다 룰렛 동작 / 마지막 스테이지에선 미션컴플리
		 */
		private function success(event : GameEvent) : void {
			SoundController.instance(root).volumeDown();

			roulette = new Roulette();
			addChild(roulette);
		}

		/*
		 * 실패시 failed 
		 */
		private function failed(event : GameEvent) : void {
			SoundController.instance(root).volumeDown();
			initFailed();
		}

		private function initFailed() : void {
			var failed : Failed = new Failed();
			addChild(failed);
		}

		private function inviteFriendListener(event : StepEvent) : void {
			inviteFriends();
		}

		/*
		 * 친구초대.
		 */
		private function inviteFriends() : void {
			friend = new InviteFriends();
			addChild(friend);
		}

		/*
		 * 1. howtoplay 나오고 게임 맵 / UI 배
		 */
		public function initHowToPlay() : void {
			var how : HowToPlay = new HowToPlay();
			addChild(how);

			uiContainer.initUI();
			gameContainer.setGame();
		}

		private function stageCountListener(event : StepEvent) : void {
			remove();
			initStageCount();
		}

		/*
		 * 2. 카운트 시
		 */
		public function initStageCount() : void {
			SoundController.instance(root).counter();

			var stageCount : StageCount = new StageCount();
			addChild(stageCount);
		}

		/*
		 * 3. 카운트 끝과 함께 케릭터 및 몬스터 움직이고 UI 시
		 */
		private function startGameListener(event : StepEvent) : void {
			remove();
			gameContainer.startGame();
			uiContainer.startGame();

			SoundController.instance(root).volumeUp();

			stage.focus = this;
		}

		private function remove() : void {
			while (numChildren) {
				removeChildAt(0);
			}
		}

		public function setUiContainer(uiContainer : UiContainer) : void {
			this.uiContainer = uiContainer;
		}

		public function setGameContainer(gameContainer : GameContainer) : void {
			this.gameContainer = gameContainer;
		}
	}
}
