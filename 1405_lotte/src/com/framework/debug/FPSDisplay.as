package com.framework.debug {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.setTimeout;

	/**
	 * 화면상에 FPS Meter 를 생성하는 클래스
	 * @author kylekaturn (http://kyle-katurn.com)
	 * @class : FPSDisplay.as
	 * @write_date : 2008. 04. 21
	 * @version : V1.0
	 */
	public class FPSDisplay extends Sprite {
		private var box : Sprite;
		private var fpsText : TextField;
		private var counter : int = 0;

		/**
		 * constructor method
		 * @param stage : refer stage object
		 */
		public function FPSDisplay() {
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}

		// ____________________________________________________________ intialize method
		private function initialize(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initialize);
			buildBox();
			buildText();
			setTimeout(updateFps, 1000);
			addEventListener(Event.ENTER_FRAME, updateFrame);
		}

		// /____________________________________________________________ private method
		private function buildBox() : void {
			box = new Sprite();
			box.graphics.beginFill(0xCCCCCC, 1);
			box.graphics.drawRect(0, 0, 50, 20);
			box.graphics.endFill();
			addChild(box);
		}

		private function buildText() : void {
			fpsText = new TextField();
			addChild(fpsText);
		}

		/**
		 * update counter var every frame
		 */
		private function updateFrame(event : Event) : void {
			counter++;
		}

		/**
		 * update display FPS text every second
		 */
		private function updateFps() : void {
			fpsText.text = "FPS : " + counter;
			counter = 0;
			setTimeout(updateFps, 1000);
		}
	}
}
