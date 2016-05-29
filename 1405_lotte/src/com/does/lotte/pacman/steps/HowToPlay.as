package com.does.lotte.pacman.steps {
	import flash.display.MovieClip;

	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.abstract.InOutMotion;
	import com.does.lotte.events.InOutMotionEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author chaesumin
	 */
	public class HowToPlay extends InOutMotion {
		public var btn : Sprite;

		public function HowToPlay() {
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
			removeEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}

		private function init() : void {
		}

		private function start() : void {
			addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}

		private function outComplete(event : InOutMotionEvent) : void {
			dispatchEvent(new StepEvent(StepEvent.STAGE_COUNT, true));
		}

		override protected function initInMotionScriptComplete() : void {
			btn.buttonMode = true;
			btn.addEventListener(MouseEvent.CLICK, btnClick);

			BtnController.down(MovieClip(btn));
		}

		private function btnClick(event : MouseEvent) : void {
			btn.buttonMode = false;
			btn.removeEventListener(MouseEvent.CLICK, btnClick);

			out();
		}
	}
}
