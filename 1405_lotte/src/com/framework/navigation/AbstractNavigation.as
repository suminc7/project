package com.framework.navigation {
	import com.framework.events.NavigationEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author sumin
	 */
	public class AbstractNavigation extends MovieClip {
		protected var i : int = -1;
		protected var a : int = -1;
		protected var total : int;
		protected var timerCount : int;
		protected var time : Timer;

		public function AbstractNavigation(total : int, timerCount : int) {
			this.total = total;
			this.timerCount = timerCount;
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			initTimer();
			initMovieClip();
		}

		protected function initTimer() : void {
			time = new Timer(timerCount, 1);
			time.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
		}

		protected function timerComplete(event : TimerEvent) : void {
			aOutStart(i);
			aOverStart(a);
			i = a;
		}

		protected function initMovieClip() : void {
			for (var i : int = 0;i < total;i++) {
				MovieClip(this["a" + i]).stop();
				MovieClip(this["a" + i]).buttonMode = true;
				MovieClip(this["a" + i]).mouseChildren = false;
				MovieClip(this["a" + i]).addEventListener(MouseEvent.MOUSE_OVER, aOver);
				MovieClip(this["a" + i]).addEventListener(MouseEvent.MOUSE_OUT, aOut);
				MovieClip(this["a" + i]).addEventListener(MouseEvent.CLICK, aClick);
			}
		}

		protected function aOver(event : MouseEvent) : void {
			time.reset();
			aOutStart(i);
			i = int(event.currentTarget.name.substr(1));
			aOverStart(i);
			dispatchEvent(new NavigationEvent(NavigationEvent.OVER, true, i));
		}

		protected function aOverStart(i : int) : void {
		}

		protected function aOut(event : MouseEvent) : void {
			time.start();
			dispatchEvent(new NavigationEvent(NavigationEvent.OUT, true, i));
		}

		protected function aOutStart(i : int) : void {
		}

		protected function aClick(event : MouseEvent) : void {
			aOutStart(a);
			a = int(event.currentTarget.name.substr(1));
			aOverStart(a);
			aClickStart();
			dispatchEvent(new NavigationEvent(NavigationEvent.CLICK, true, a));
		}

		protected function aClickStart() : void {
		}

		protected function setNavi(a : int) : void {
			i = -1;
			aOutStart(this.a);
			aOverStart(a);
			this.a = a;
			aClickStart();
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}
	}
}
