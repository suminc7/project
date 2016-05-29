package com.framework.bitmap {
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;

	/**
	 * @author Sumin
	 * @date 2009. 01. 21
	 * @file Shadow.as 
	 */
	public class Shadow extends Sprite {
		private var shadowBitmap : Bitmap;
		private var shadowBitmapData : BitmapData;
		private var boxWidth : int;
		private var boxHeight : int;

		/*
		 * main3d shadow create
		 */
		public function Shadow(mc : DisplayObject, alpha : Array, ratio : Array) {
			boxWidth = mc.width;
			boxHeight = mc.height;

			var scaleMatrix : Matrix = new Matrix();
			scaleMatrix.translate(0, -boxHeight);
			scaleMatrix.scale(1, -1);

			shadowBitmapData = new BitmapData(boxWidth, boxHeight, true, 0x00ffffff);
			shadowBitmapData.draw(mc, scaleMatrix);

			var matrix : Matrix = new Matrix();
			var deg : Number = 90 * Math.PI / 180;
			matrix.createGradientBox(boxWidth, boxHeight, deg, 0, 0);
			var color : Array = [0xffffff, 0xffffff];

			var gradientMatrix : Sprite = new Sprite();
			gradientMatrix.graphics.beginGradientFill(GradientType.LINEAR, color, alpha, ratio, matrix);
			gradientMatrix.graphics.drawRect(0, 0, boxWidth, boxHeight);
			gradientMatrix.graphics.endFill();

			var gradientData : BitmapData = new BitmapData(boxWidth, boxHeight, true, 0x00000000);
			gradientData.draw(gradientMatrix);

			shadowBitmapData.copyPixels(shadowBitmapData, shadowBitmapData.rect, new Point(), gradientData);

			shadowBitmap = new Bitmap(shadowBitmapData, "auto", true);
			addChild(shadowBitmap);
		}
	}
}
