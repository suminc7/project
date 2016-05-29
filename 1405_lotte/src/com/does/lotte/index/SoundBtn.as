package com.does.lotte.index {
	import com.does.lotte.controller.SoundController;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class SoundBtn extends MovieClip {
		private var isEnable : Boolean = true;
		public function SoundBtn() {
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
			buttonMode = true;
			addEventListener(MouseEvent.CLICK, thisClick);
		}

		private function thisClick(event : MouseEvent) : void {
			
			
			if(isEnable){
				isEnable = false;
				SoundController.instance(root).offSoundAll();
				gotoAndStop(2);
			}else{
				isEnable = true;
				SoundController.instance(root).onSoundAll();
				gotoAndStop(1);
			}
			
			
		}
	}
}
