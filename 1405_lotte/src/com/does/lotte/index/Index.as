package com.does.lotte.index {
	import com.chargedweb.utils.ResourceMonitor;
	import com.does.lotte.events.GameEvent;
	import com.framework.system.SecurityUse;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.SWFLoader;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class Index extends Sprite {
		public var loading : MovieClip;
		private var soundBtn : SoundBtn;

		public function Index() {
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
			loading.addEventListener("MAIN_LOADING_COMPLETE", mainLoadingComplete);

			
		}

		private function mainLoadingComplete(event : GameEvent) : void {
			loading.removeEventListener("MAIN_LOADING_COMPLETE", mainLoadingComplete);
			
			var loader : SWFLoader = new SWFLoader(SecurityUse.getSwfParentPath(root) + "swf/pacman.swf", {name:"mainSWF", container:this, onComplete:onComplete});
			loader.load();

			function onComplete(event : LoaderEvent) : void {
				loading.stop();
				removeChild(loading);
				
				
				soundBtn = new SoundBtn();
				soundBtn.x = 970;
				soundBtn.y = 65;
				addChild(soundBtn);
			}
		}

		
	}
}
