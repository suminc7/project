package com.does.lotte.pacman.ui {
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.global.GameData;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class TimerView extends Sprite {
		public var btn : Sprite;
		public var bar : MovieClip;
		private var btnFx : int;
		private var startX : int = 92;
		private var endX : int = 305;

		public function TimerView() {
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
			btnFx = btn.x;

			reset();
		}

		private function start() : void {
			stage.addEventListener(GameEvent.FAILED, failed);
			stage.addEventListener(GameEvent.SUCCESS, failed);
		}


		private function failed(event : GameEvent) : void {
			TweenMax.killTweensOf(btn);
		}

		private function setBarWidth() : void {
			bar.width = btn.x - bar.x + 3;
		}

		public function reset() : void {
			TweenMax.to(btn, 0, {x:endX});
			setBarWidth();
		}

		public function setTime(per : Number) : void {
			btn.x = endX - (endX - startX) * per;
			setBarWidth();
		}
	}
}
