package com.framework.stage {
	import com.framework.types.StageAlignType;
	import com.greensock.TweenMax;

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class StageResizeManager {
		private static var stage : Stage;
		private static var stageHeight : int;
		private static var stageWidth : int;
		private static var sArr : Array = new Array();

		/*
		 * @param stage
		 * @param stageWidth - document properties wid size
		 * @param stageHeight - document properties hei size
		 * @example 
		 * StageResizeManager.init(stage, 1000, 600);
		 * addChild 이후에 StageResizeManager.resize(contents, StageAlignType.CENTER, 0, null, -100 / 20, -600 / 2); 
		 * 		 */
		public static function init(stage : Stage, stageWidth : int, stageHeight : int) : void {
			if (StageResizeManager.stage) return;
			StageResizeManager.stageWidth = stageWidth;
			StageResizeManager.stageHeight = stageHeight;
			StageResizeManager.stage = stage;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener(Event.RESIZE, stageResizeListener);
		}

		/*
		 * @param mc, StageAlignType, time, ease, offsetX, offsetY
		 * StageResizeManager.resize(contents, StageAlignType.CENTER, 0, null, -100 / 20, -600 / 2); 
		 */
		public static function resize(mc : *, align : String, time : Number, ease : Function = null, ox : int = 0, oy : int = 0) : void {
			sArr.push({mc:mc, align:align, time:time, ease:ease, mx:mc.x, my:mc.y, ox:ox, oy:oy});
			stageResize(true);
		}

		private static function stageResizeListener(event : Event) : void {
			stageResize();
		}

		private static function stageResize(chk : Boolean = false) : void {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) return;

			for (var i : int = 0;i < sArr.length;i++) {
				if (sArr[i].mc.stage) {
					stageResizeFunc(i, chk);
				} else {
					sArr.splice(i, 1);
				}
			}
		}

		private static function stageResizeFunc(i : int, chk : Boolean) : void {
			var s : Object = sArr[i] as Object;
			var time : Number = chk ? 0 : s.time;

			if (s.align == StageAlignType.CENTER) {
				setPosition(s, time, w / 2 + s.ox, h / 2 + s.oy);
			} else if (s.align == StageAlignType.TOP) {
				setPosition(s, time, w / 2 + s.ox, s.oy);
			} else if (s.align == StageAlignType.TOP_RIGHT) {
				setPosition(s, time, w + s.ox, s.oy);
			} else if (s.align == StageAlignType.TOP_LEFT) {
				setPosition(s, time, s.ox, s.oy);
			} else if (s.align == StageAlignType.RIGHT) {
				setPosition(s, time, w + s.ox, h / 2 + s.oy);
			} else if (s.align == StageAlignType.LEFT) {
				setPosition(s, time, s.ox, h / 2 + s.oy);
			} else if (s.align == StageAlignType.BOTTOM_RIGHT) {
				setPosition(s, time, w + s.ox, h + s.oy);
			} else if (s.align == StageAlignType.BOTTOM) {
				setPosition(s, time, w / 2 + s.ox, h + s.oy);
			} else if (s.align == StageAlignType.BOTTOM_LEFT) {
				setPosition(s, time, s.ox, h + s.oy);
			} else if (s.align == StageAlignType.WIDTH) {
				setWidth(s, time, w + s.ox);
			} else if (s.align == StageAlignType.HEIGHT) {
				setHeight(s, time, w + h + s.oy);
			}
		}

		private static function setPosition(s : Object, time : Number, nx : Number, ny : Number) : void {
			TweenMax.to(s.mc, time, {x:Math.floor(nx), y:Math.floor(ny), ease:s.ease});
		}

		private static function setWidth(s : Object, time : Number, nw : Number) : void {
			TweenMax.to(s.mc, time, {width:nw, ease:s.ease});
		}

		private static function setHeight(s : Object, time : Number, nh : Number) : void {
			TweenMax.to(s.mc, time, {height:nh, ease:s.ease});
		}

		public static function get w() : Number {
			return stage.stageWidth > stageWidth ? stage.stageWidth : stageWidth;
		}

		public static function get h() : Number {
			return stage.stageHeight > stageHeight ? stage.stageHeight : stageHeight;
		}
	}
}
