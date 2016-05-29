package com.does.lotte.pacman.steps {
	import com.does.lotte.global.GameData;
	import flash.display.MovieClip;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.abstract.InOutMotion;
	import com.does.lotte.events.InOutMotionEvent;

	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class StageCount extends InOutMotion {
		
		public var stageMc : MovieClip;
		
		public function StageCount() {
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
			var n : int = GameData.currentStep;
			
			stageMc.gotoAndStop(n);
		}

		private function start() : void {
			addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}

		private function outComplete(event : InOutMotionEvent) : void {
			dispatchEvent(new StepEvent(StepEvent.START_GAME, true));
		}
	}
}
