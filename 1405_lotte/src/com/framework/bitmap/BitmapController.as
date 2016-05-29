package com.framework.bitmap {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	/**
	 * @author suminc7
	 */
	public class BitmapController {
		static public function spriteToBitmap(obj : DisplayObject) : Bitmap {
			var bitmapdata : BitmapData = new BitmapData(obj.width, obj.height, true, 0x00ffffff);
			bitmapdata.draw(obj);
			var bitmap : Bitmap = new Bitmap(bitmapdata, "auto", true);
			return bitmap;
		}
	}
}
