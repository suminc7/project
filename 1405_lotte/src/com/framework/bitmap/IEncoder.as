package com.framework.bitmap {
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	/**
	 * @author sumin
	 */
	public interface IEncoder {
		function encode(bitmapData : BitmapData) : ByteArray;
	}
}
