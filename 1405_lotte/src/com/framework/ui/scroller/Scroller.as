package com.framework.ui.scroller {
	import flash.external.ExternalInterface;

	import com.framework.events.UiScrollEvent;
	import com.framework.types.ScrollType;
	import com.greensock.TweenMax;
	import com.greensock.easing.Strong;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author suminc7
	 */
	public class Scroller extends Sprite {
		public var space : Number = 5;
		private var seekBar : Sprite;
		private var seekBtn : Sprite;
		private var scroll : UiScroll;
		private var mc : Sprite;
		private var msk : Sprite;
		private var t : Number;
		private var type : String;
		private var my : Number;
		private var mx : Number;
		public var s : Stage;

		public function Scroller(stage : Stage, type : String, mc : Sprite, seekBar : Sprite, seekBtn : Sprite, t : Number) {
			this.s = stage;
			this.type = type;
			this.mc = mc;
			this.seekBar = seekBar;
			this.seekBtn = seekBtn;
			this.t = t;
			mx = mc.x;
			my = mc.y;

			init();

			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
		}

		private function init() : void {
			initListener();
			initMask();
			initSeekBtn();
			initUIScroll();
		}

		private function initListener() : void {
			s.addEventListener(MouseEvent.MOUSE_WHEEL, thisMouseWheel);
		}

		private function thisMouseWheel(event : MouseEvent) : void {
			if (!hitTestPoint(s.mouseX, s.mouseY)) return;
			if (type == ScrollType.VERTICAL) {
				if (event.delta == 0 || msk.height >= mc.height) {
					return;
				} else if (event.delta <= 1) {
					if ((seekBtn.y + space) <= (msk.y + msk.height - seekBtn.height)) {
						seekBtn.y = seekBtn.y + space;
					} else {
						seekBtn.y = msk.y + msk.height - seekBtn.height;
					}
					scroll.stageMouseMove(null);
				} else if (event.delta >= -1) {
					if ((seekBtn.y - space) >= msk.y) {
						seekBtn.y = seekBtn.y - space;
					} else {
						seekBtn.y = msk.y;
					}
					scroll.stageMouseMove(null);
				}

				// seekBtn.y = event.delta < 0 ? (seekBtn.y + space) <= (msk.y + msk.height - seekBtn.height) ? (seekBtn.y + space) : (msk.y + msk.height - seekBtn.height) : (msk.y <= seekBtn.y - space) ? (seekBtn.y - space) : msk.y;
			} else if (type == ScrollType.HORIZONTAL) {
				seekBtn.x = event.delta < 0 ? seekBtn.x + space <= msk.x + msk.width - seekBtn.width ? seekBtn.x + space : msk.x + msk.width - seekBtn.width : 0 <= seekBtn.x - space ? seekBtn.x - space : 0;
			}
			// scroll.stageMouseMove(null);
		}

		private function initMask() : void {
			msk = new Sprite();
			msk.graphics.beginFill(0x000000, .1);
			msk.graphics.drawRect(0, 0, type == ScrollType.VERTICAL ? mc.width : mc.height, type == ScrollType.VERTICAL ? seekBar.height : seekBar.width);
			msk.graphics.endFill();
			msk.x = mc.x;
			msk.y = mc.y;
			addChild(msk);
			setMask();
		}

		private function setMask() : void {
			mc.mask = msk;
		}

		private function initUIScroll() : void {
			scroll = new UiScroll(type, seekBar, seekBtn, t);
			scroll.addEventListener(UiScrollEvent.SCROLL_MOVE, scrollMoveListener);
		}

		private function initSeekBtn() : void {
			setScale();
		}

		private function setScale() : void {
			if (msk.height >= mc.height) {
				seekBtn.visible = false;
				seekBar.mouseEnabled = false;
			} else {
				seekBtn.visible = true;
				seekBar.mouseEnabled = true;
			}
			if (type == ScrollType.VERTICAL) {
				seekBtn.scaleY = msk.height / mc.height;
				seekBtn.scaleY = seekBtn.scaleY > .8 ? .8 : seekBtn.scaleY;
				seekBtn.scaleY = seekBtn.scaleY < .1 ? .1 : seekBtn.scaleY;
			} else {
				seekBtn.scaleX = msk.width / mc.width;
				seekBtn.scaleX = seekBtn.scaleX > .8 ? .8 : seekBtn.scaleX;
				seekBtn.scaleX = seekBtn.scaleX < .1 ? .1 : seekBtn.scaleX;
			}
			space = msk.height / mc.height * 5;
		}

		public function reset() : void {
			msk.x = mc.x = mx;
			msk.y = mc.y = my;
			setScale();
			setMask();
			scroll.reset();
		}

		private function scrollMoveListener(event : UiScrollEvent) : void {
			if (type == ScrollType.VERTICAL) {
				TweenMax.to(mc, t, {y:msk.y + event.num * (seekBar.height - mc.height), ease:Strong.easeOut});
			} else if (type == ScrollType.HORIZONTAL) {
				TweenMax.to(mc, t, {x:msk.x + event.num * (seekBar.width - mc.width), ease:Strong.easeOut});
			}
		}

		private function initRemoveStage(event : Event) : void {
			s.removeEventListener(MouseEvent.MOUSE_WHEEL, thisMouseWheel);
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}
	}
}
