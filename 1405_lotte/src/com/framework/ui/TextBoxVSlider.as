package com.framework.ui {
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author zt
	 */
	public class TextBoxVSlider extends Sprite {
		private var w : int, h : Number;
		private var w_2 : int;
		private var md_flg : Boolean = false;
		private var g : Graphics;

		public function get SliderHeight() : Number {
			return h;
		}

		public function set SliderHeight(value : Number) : void {
			h = value;
			drawUp();
		}

		public function TextBoxVSlider(width : int, height : int) {
			w = width;
			h = height;
			// w_2 = (w >> 1) + 2;
			w_2 = 0;
			g = this.graphics;
			drawUp();
			this.addEventListener(MouseEvent.ROLL_OVER, function(e : MouseEvent) : void {
				if (md_flg) return;
				drawOver();
				addEventListener(MouseEvent.ROLL_OUT, onOut);
			});

			this.addEventListener(MouseEvent.MOUSE_DOWN, function(e : MouseEvent) : void {
				md_flg = true;
				drawDown();
				stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
			});
		}

		private function onOut(e : MouseEvent) : void {
			removeEventListener(MouseEvent.MOUSE_OUT, onOut);
			if (md_flg) return;
			drawUp();
		}

		private function onUp(e : MouseEvent) : void {
			drawUp();
			md_flg = false;
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
		}

		private function drawUp() : void {
			g.clear();
			// g.lineStyle(w, 0x666666, 1, true, "normal", flash.display.CapsStyle.NONE);
			// g.moveTo(w_2, w_2);
			// g.lineTo(w_2, h - w_2);
			g.beginFill(0x3FBDF2);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}

		private function drawDown() : void {
			g.clear();
			// g.lineStyle(w, 0x666666, 1, true, "normal", flash.display.CapsStyle.NONE);
			// g.moveTo(w_2, w_2);
			// g.lineTo(w_2, h - w_2);
			g.beginFill(0x3FBDF2);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}

		private function drawOver() : void {
			g.clear();
			// g.lineStyle(w, 0x666666, 1, true, "normal", flash.display.CapsStyle.NONE);
			// g.moveTo(w_2, w_2);
			// g.lineTo(w_2, h - w_2);
			g.beginFill(0x3FBDF2);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}
	}
}
