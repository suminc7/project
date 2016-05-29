package com.framework.movieclip {
	import com.framework.events.UiScrollEvent;

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	/**
	 * @author sumin
	 */
	public class FrameController extends EventDispatcher {
		private static var seekBar : MovieClip;
		private static var seekBtn : MovieClip;
		private static var stage : Stage;
		private static var point : Point = new Point();

		public function FrameController(seekBar : MovieClip, seekBtn : MovieClip) {
			FrameController.seekBar = seekBar;
			FrameController.seekBtn = seekBtn;
			FrameController.stage = seekBar.stage;

			seekBtn.buttonMode = true;
			seekBtn.addEventListener(MouseEvent.MOUSE_DOWN, btnDown);
		}

		private function btnDown(event : MouseEvent) : void {
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		private function mouseUp(event : MouseEvent) : void {
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}

		private function mouseMove(event : MouseEvent) : void {
			var n : Number = (seekBar.localToGlobal(point).x + seekBar.width - event.stageX) / seekBar.width;
			var num : Number = n < 0 ? 0 : n > 1 ? 1 : n;
			dispatchEvent(new UiScrollEvent(UiScrollEvent.SCROLL_MOVE, false, num));
		}
	}
}
