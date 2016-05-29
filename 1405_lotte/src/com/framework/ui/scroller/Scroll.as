package com.framework.ui.scroller {
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;

	import flash.geom.Rectangle;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.Sprite;

	/**
	 * @author sumin
	 */
	public class Scroll extends Sprite {
		public var space : int = 10;
		private var mc_move : MovieClip;
		private var mc_mask : MovieClip;
		private var mc_btn : MovieClip;
		private var rec : Rectangle;

		public function Scroll(mc_move : MovieClip, mc_mask : MovieClip, mc_btn : MovieClip) {
			this.mc_move = mc_move;
			this.mc_mask = mc_mask;
			this.mc_btn = mc_btn;
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			initMovieClip();
			initStage();
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, thisMouseWheel);
			mc_btn.buttonMode = false;
			mc_btn.removeEventListener(MouseEvent.MOUSE_DOWN, btnMouseDown);
		}

		private function initStage() : void {
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, thisMouseWheel);
		}

		private function thisMouseWheel(event : MouseEvent) : void {
			if (event.delta < 0) {
				if ((mc_btn.y + space) <= (mc_mask.height - mc_btn.height)) {
					mc_btn.y += space;
				} else {
					mc_btn.y = (mc_mask.height - mc_btn.height);
				}
			} else {
				if (0 <= (mc_btn.y - space)) {
					mc_btn.y -= space;
				} else {
					mc_btn.y = 0;
				}
			}
			stageMouseMove(null);
		}

		private function initMovieClip() : void {
			mc_move.mask = mc_mask;

			mc_btn.buttonMode = true;
			mc_btn.addEventListener(MouseEvent.MOUSE_DOWN, btnMouseDown);

			// rec = new Rectangle(mc_btn.x, mc_btn.y, 0, mc_mask.height - mc_btn.height);
			rec = new Rectangle(mc_btn.x, mc_btn.y, 0, mc_mask.height);
		}

		private function btnMouseDown(event : MouseEvent) : void {
			mc_btn.startDrag(false, rec);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}

		private function stageMouseUp(event : MouseEvent) : void {
			mc_btn.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
		}

		private function stageMouseMove(event : MouseEvent) : void {
			TweenLite.to(mc_move, .6, {y:mc_btn.y / (mc_mask.height - mc_btn.height) * (mc_mask.height - mc_move.height), ease:Strong.easeOut});
		}
	}
}
