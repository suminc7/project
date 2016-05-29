package com.framework.ui {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;

	/**
	 * @author zt
	 */
	public class TextBoxVScrollBar extends Sprite {
		private var t : TextField;
		private var w : int, h : int;
		// Line
		private var lineHeight : Number;
		// item
		private var slider : TextBoxVSlider;
		private var cY : int;
		private var minY : int;
		private var maxY : int;

		public function TextBoxVScrollBar(target : TextField, width : int, height : int) {
			t = target;
			w = width;
			h = height;
			lineHeight = t.textHeight / t.numLines;

			var g : Graphics = this.graphics;
			g.beginFill(0xECECEC);
			g.drawRect(0, 0, 6, height);
			g.endFill();
			initGUI();

			t.addEventListener(Event.SCROLL, function(e : Event) : void {
				slider.y = int((t.scrollV - 1) * lineHeight + minY);
			});

			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e : MouseEvent) : void {
				var pos : int = mouseY;
				if (pos <= minY) return;
				if (pos >= maxY + slider.height) return;
				if ( pos >= slider.y && pos <= (slider.y + slider.height)) return;

				if (pos >= maxY) pos -= slider.height;
				slider.y = pos;
				t.scrollV = int((pos - minY) / lineHeight) + 1;
			});
		}

		public function reSet(target : TextField, width : int, height : int) : void {
			var d : Number = t.height ;
			d *= d / t.textHeight;
			t = target;
			w = width;
			h = height;
			maxY = ((t.height) - d) ;
			lineHeight = (maxY - minY) / ( t.maxScrollV - 1);
			;
			slider.SliderHeight = d;
		}

		private function initGUI() : void {
			var d : Number = t.height ;
			d *= d / t.textHeight;
			// d = 80;
			slider = new TextBoxVSlider(6, d);
			slider.x = 0;
			slider.y = minY = t.y - t.y ;
			maxY = ((t.height) - d) ;
			lineHeight = (maxY - minY) / ( t.maxScrollV - 1);
			addChild(slider);

			slider.addEventListener(MouseEvent.MOUSE_DOWN, function(e : MouseEvent) : void {
				cY = slider.mouseY + t.height;
				slider.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
				slider.stage.addEventListener(MouseEvent.MOUSE_UP, offMove);
			});
		}

		private function onMove(e : MouseEvent) : void {
			var point : Point = new Point(stage.mouseX, stage.mouseY);
			var yy : int = globalToLocal(point).y ;
			// var yy : int = stage.mouseY - cY;
			if (yy <= minY) yy = minY;
			if (yy >= maxY) yy = maxY;
			slider.y = yy;
			t.scrollV = int((yy - minY) / lineHeight) + 1;
		}

		private function offMove(e : MouseEvent) : void {
			slider.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			slider.stage.removeEventListener(MouseEvent.MOUSE_UP, offMove);
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}
	}
}
