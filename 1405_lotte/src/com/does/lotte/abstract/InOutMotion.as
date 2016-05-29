package com.does.lotte.abstract {
	import com.does.lotte.events.InOutMotionEvent;

	import flash.display.FrameLabel;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author Administrator
	 */
	public class InOutMotion extends MovieClip {
		public function InOutMotion() {
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
			stop();
			initAddScript();
		}

		private function start() : void {
			play();
		}

		protected function initAddScript() : void {
			for (var i : int = 0;i < currentLabels.length;i++) {
				if (FrameLabel(currentLabels[i]).name == "in") {
					addFrameScript(FrameLabel(currentLabels[i]).frame, inMotionScript);
				}
				if (FrameLabel(currentLabels[i]).name == "out") {
					addFrameScript(FrameLabel(currentLabels[i]).frame - 2, inCompleteScript);
					addFrameScript(FrameLabel(currentLabels[i]).frame - 1, outMotionScript);
				}
			}
			addFrameScript(totalFrames - 1, outCompleteScript);
		}

		public function inMotionScript() : void {
			dispatchEvent(new InOutMotionEvent(InOutMotionEvent.IN_MOTION_START, true));
		}

		public function inCompleteScript() : void {
			stop();
			initInMotionScriptComplete();
			dispatchEvent(new InOutMotionEvent(InOutMotionEvent.IN_MOTION_COMPLETE, true));
		}

		public function outMotionScript() : void {
			dispatchEvent(new InOutMotionEvent(InOutMotionEvent.OUT_MOTION_START, true));
		}

		public function outCompleteScript() : void {
			stop();
			dispatchEvent(new InOutMotionEvent(InOutMotionEvent.OUT_MOTION_COMPLETE, true));
		}

		protected function initInMotionScriptComplete() : void {
		}

		public function out() : void {
			gotoAndPlay("out");
		}
	}
}
