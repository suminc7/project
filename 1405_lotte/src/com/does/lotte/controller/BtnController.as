package com.does.lotte.controller {
	import com.greensock.TweenMax;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author suminc7
	 */
	public class BtnController {
		static public function frame(mc : MovieClip) : void {
			//
			mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseOver(event : MouseEvent) : void {
				TweenMax.to(mc, mc.totalFrames - 2, {frame:mc.totalFrames, useFrames:true});
			}
			function mouseOut(event : MouseEvent) : void {
				TweenMax.to(mc, mc.totalFrames - 2, {frame:1, useFrames:true});
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}

		static public function next(mc : MovieClip) : void {
			TweenMax.to(mc, mc.totalFrames - 2, {frame:mc.totalFrames, useFrames:true});
		}

		static public function prev(mc : MovieClip) : void {
			TweenMax.to(mc, mc.totalFrames - 2, {frame:1, useFrames:true});
		}

		static public function color1(mc : MovieClip) : void {
			//
			mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseOver(event : MouseEvent) : void {
				TweenMax.to(mc, .3, {tint:0x004661});
			}
			function mouseOut(event : MouseEvent) : void {
				TweenMax.to(mc, .3, {tint:null});
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}

		static public function color2(mc : MovieClip) : void {
			//
			mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseOver(event : MouseEvent) : void {
				TweenMax.to(mc, .3, {tint:0x25AAE1});
			}
			function mouseOut(event : MouseEvent) : void {
				TweenMax.to(mc, .3, {tint:null});
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}

		static public function sound(mc : MovieClip) : void {
			//
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			mc.addEventListener(MouseEvent.CLICK, mouseClick);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseOver(event : MouseEvent) : void {
				// SoundController.over();
			}
			function mouseClick(event : MouseEvent) : void {
				// SoundController.click();
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				mc.removeEventListener(MouseEvent.CLICK, mouseClick);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}

		static public function over(mc : MovieClip) : void {
			//
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseOver(event : MouseEvent) : void {
				mc.gotoAndStop(2);
			}
			function mouseOut(event : MouseEvent) : void {
				mc.gotoAndStop(1);
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}

		static public function down(mc : MovieClip) : void {
			//
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			mc.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseDown(event : MouseEvent) : void {
				mc.gotoAndStop(2);
			}
			function mouseUp(event : MouseEvent) : void {
				mc.gotoAndStop(1);
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				mc.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}

		static public function overdown(mc : MovieClip) : void {
			//
			mc.mouseChildren = false;
			mc.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			mc.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			mc.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			mc.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			mc.addEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			//
			function mouseDown(event : MouseEvent) : void {
				mc.gotoAndStop(3);
			}
			function mouseUp(event : MouseEvent) : void {
				mc.gotoAndStop(2);
			}
			function mouseOver(event : MouseEvent) : void {
				mc.gotoAndStop(2);
			}
			function mouseOut(event : MouseEvent) : void {
				mc.gotoAndStop(1);
			}
			function removeFromStageListener(event : Event) : void {
				mc.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				mc.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				mc.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
				mc.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
				mc.removeEventListener(Event.REMOVED_FROM_STAGE, removeFromStageListener);
			}
		}
	}
}
