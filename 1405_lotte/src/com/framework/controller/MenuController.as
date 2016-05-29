package com.framework.controller {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author suminc7
	
	var menu : MenuController = new MenuController();
	menu.push(mc);
	menu.init(menuOver, menuOut, menuClick);
	menu.setMenu(0);
	
	
	function menuOver(menu : Sprite, i : int) : void {
	TweenMax.to(menu, .6, {alpha:1});
	}
	
	function menuOut(menu : Sprite, i : int) : void {
	TweenMax.to(menu, .6, {alpha:0});
	}
	
	function menuClick(menu : Sprite = null, a : int = -1) : void {
	}	

	 */
	public class MenuController extends Sprite {
		private var menuArr : Array = new Array();
		private var time : Timer;
		private var i : int = -1;
		private var a : int = -1;
		private var overFunc : Function;
		private var outFunc : Function;
		private var clickFunc : Function;
		private var isKeep : Boolean;
		private var t : Number;

		public function MenuController() {
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
		}

		public function init(overFunc : Function, outFunc : Function, clickFunc : Function, isKeep : Boolean = true, t : Number = 300) : void {
			this.overFunc = overFunc;
			this.outFunc = outFunc;
			this.clickFunc = clickFunc;
			this.isKeep = isKeep;
			this.t = t;
			initTimer();
			initMenu();
		}

		private function initMenu() : void {
			for (var i : int = 0;i < menuArr.length;i++) {
				var menu : MovieClip = menuArr[i] as MovieClip;
				menu.buttonMode = true;
				menu.stop();
				menu.addEventListener(MouseEvent.MOUSE_OVER, menuOver);
				menu.addEventListener(MouseEvent.MOUSE_OUT, menuOut);
				menu.addEventListener(MouseEvent.CLICK, menuClick);
			}
		}

		private function menuOver(event : MouseEvent) : void {
			time.reset();
			menuOutStart(i);
			i = menuArr.indexOf(event.currentTarget);
			menuOverStart(i);
		}

		private function menuOut(event : MouseEvent) : void {
			time.start();
		}

		private function menuClick(event : MouseEvent) : void {
			menuOutStart(i);
			menuOutStart(a);
			a = i = menuArr.indexOf(event.currentTarget);
			menuOverStart(a);
			menuClickStart(a);
		}

		private function initTimer() : void {
			time = new Timer(t, 1);
			time.addEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
		}

		private function timerComplete(event : TimerEvent) : void {
			menuOutStart(i);
			menuOverStart(a);
			i = a;
		}

		private function menuOverStart(i : int) : void {
			if (i != -1) {
				overFunc.call(null, menuArr[i], i);
			}
		}

		private function menuOutStart(i : int) : void {
			if (isKeep) {
				if (a != this.i && i != -1) {
					outFunc.call(null, menuArr[i], i);
				}
			} else {
				if (i != -1) {
					outFunc.call(null, menuArr[i], i);
				}
			}
		}

		private function menuClickStart(a : int) : void {
			clickFunc.call(null, menuArr[a], a);
		}

		public function push(menu : Sprite) : void {
			menuArr.push(menu);
		}

		public function setMenu(a : int) : void {
			i = -1;
			menuOutStart(this.a);
			menuOverStart(a);
			this.a = a;
		}

		private function initRemoveStage(event : Event) : void {
			menuArr = null;
			time.removeEventListener(TimerEvent.TIMER_COMPLETE, timerComplete);
			time = null;
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}
	}
}
