package com.framework.ui.scroller {
	import flash.events.EventDispatcher;
	import flash.display.Stage;

	import com.framework.types.ScrollType;
	import com.greensock.easing.Strong;
	import com.framework.events.UiScrollEvent;
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Sumin
	 * @date 2009. 01. 02
	 * @file VolumeScrollbar.as 
	 */
	public class UiScroll extends EventDispatcher {
		protected var seekBar : Sprite;
		protected var seekBtn : Sprite;
		protected var num : Number;
		protected var t : Number;
		private var upCheck : Boolean;
		private var rect : Rectangle;
		private var type : String;
		private var by : Number;
		private var center : Boolean;
		private var stage : Stage;

		public function UiScroll(type : String, seekBar : Sprite, seekBtn : Sprite, t : Number, center : Boolean = false) {
			this.type = type;
			this.seekBar = seekBar;
			this.seekBtn = seekBtn;
			this.t = t;
			this.center = center;
			by = seekBtn.y;
			stage = seekBar.stage;

			init();
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}

		private function init() : void {
			initRect();
			initSprite();
		}

		private function initSprite() : void {
			seekBtn.buttonMode = true;
			seekBtn.addEventListener(MouseEvent.MOUSE_DOWN, seekBtnMouseDown);
			seekBar.addEventListener(MouseEvent.CLICK, seekBarClick);
		}

		private function initRect() : void {
			if (type == ScrollType.VERTICAL) {
				rect = new Rectangle(seekBtn.x, seekBtn.y, 0, btnHeight);
			} else if (type == ScrollType.HORIZONTAL) {
				rect = new Rectangle(seekBar.x, seekBtn.y, btnWidth, 0);
			}
		}

		private function seekBarClick(event : MouseEvent) : void {
			if (type == ScrollType.VERTICAL) {
				var ly : Number = event.localY + seekBtn.height > seekBar.height ? btnHeight : event.localY;
				num = ly / btnHeight;
			} else if (type == ScrollType.HORIZONTAL) {
				var lx : Number = event.localX + seekBtn.width > seekBar.width ? btnWidth : event.localX;
				num = lx / btnWidth;
			}
			setSeekBtnPos(num);
		}

		private function seekBtnMouseDown(event : MouseEvent) : void {
			upCheck = true;
			seekBtn.startDrag(false, rect);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}

		private function stageMouseUp(event : MouseEvent) : void {
			upCheck = false;
			seekBtn.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}

		public function reset() : void {
			seekBtn.y = by;
			initRect();
		}

		public function stageMouseMove(event : MouseEvent) : void {
			if (type == ScrollType.VERTICAL) {
				num = (seekBtn.y - seekBar.y) / btnHeight;
			} else if (type == ScrollType.HORIZONTAL) {
				num = (seekBtn.x - seekBar.x) / btnWidth;
			}
			dispatchEvent(new UiScrollEvent(UiScrollEvent.SCROLL_MOVE, true, num, t));
		}

		public function setSeekBtnPos(num : Number, t : Number = 1) : void {
			if (type == ScrollType.VERTICAL) {
				TweenMax.to(seekBtn, t, {y:seekBar.y + btnHeight * num, onUpdate:posUpdate, onUpdateParams:[num, t], ease:Strong.easeOut});
			} else if (type == ScrollType.HORIZONTAL) {
				TweenMax.to(seekBtn, t, {x:seekBar.x + btnWidth * num, onUpdate:posUpdate, onUpdateParams:[num, t], ease:Strong.easeOut});
			}
			dispatchEvent(new UiScrollEvent(UiScrollEvent.SCROLL_MOVE, false, num, t));
		}

		private function posUpdate(num : Number, t : Number = 1) : void {
			dispatchEvent(new UiScrollEvent(UiScrollEvent.SCROLL_MOVE, false, num, t));
		}

		private function get btnWidth() : Number {
			return center ? seekBar.width : seekBar.width - seekBtn.width;
		}

		private function get btnHeight() : Number {
			return center ? seekBar.height : seekBar.height - seekBtn.height;
		}
	}
}
