package com.does.lotte.pacman.steps {
	import com.does.lotte.global.Tracking;
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.GameEvent;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;

	/**
	 * @author chaesumin
	 */
	public class Main extends MovieClip {
		public var startBtn : Sprite;
		public var skip : Sprite;

		public function Main() {
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
			skip.buttonMode = true;
			skip.addEventListener(MouseEvent.CLICK, skipClick);
			
			
			if (FrameLabel(currentLabels[0]).name == "loop") {
				addFrameScript(FrameLabel(currentLabels[0]).frame - 1, inMotionScript);
			}
		}

		private function inMotionScript() : void {
			startBtn.buttonMode = true;
			startBtn.addEventListener(MouseEvent.CLICK, startBtnClick);
			
			

			BtnController.down(MovieClip(startBtn));
		}

		private function skipClick(event : MouseEvent) : void {
			gotoAndPlay("loop");
		}

		private function startBtnClick(event : MouseEvent) : void {
			
			Tracking.track("click", "Game_Start");
			
			var isLogin : String = ExternalInterface.call("GAME.login");
			
			if(isLogin == "true"){
				dispatchEvent(new GameEvent(GameEvent.INIT_GAME, true));
			}else{
				
			}
			
			
			
		}
	}
}
