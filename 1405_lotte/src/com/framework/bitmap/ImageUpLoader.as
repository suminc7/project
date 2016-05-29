package com.framework.bitmap {
	import com.framework.events.SaveImageEvent;
	import com.framework.types.ImageUploadType;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Matrix;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;

	/**
	 * @author Sumin
	 * @date 2009. 01. 06
	 * @file SaveImage.as 
	 */
	public class ImageUpLoader extends EventDispatcher {
		private var _encoder : IEncoder;
		private var _data : String;
		private var _bitmapdata : BitmapData;

		public function ImageUpLoader(url : String, obj : *, w : int = 0, h : int = 0, type : String = ImageUploadType.JPG, quality : int = 100, matrix : Matrix = null) {
			if (obj is DisplayObject) {
				_bitmapdata = new BitmapData(w, h, true, 0x00ffffff);
				_bitmapdata.draw(obj, matrix, null, null, null, true);
			} else if (obj is BitmapData) {
				_bitmapdata = obj;
			}

			var request : URLRequest = new URLRequest(url);
			if (type == ImageUploadType.JPG) _encoder = new JPEGEncoder(quality);
			if (type == ImageUploadType.PNG) _encoder = new PNGEncoder();
			if (type == ImageUploadType.BMP) _encoder = new BMPEncoder();
			var objByteData : ByteArray = _encoder.encode(_bitmapdata);

			request.data = objByteData;
			request.method = URLRequestMethod.POST;
			request.contentType = 'application/octet-stream';

			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
		}

		private function loadComplete(event : Event) : void {
			_data = event.target.data;
			dispatchEvent(new SaveImageEvent(SaveImageEvent.SAVE_IMAGE_COMPLETE, true));
		}

		public function get data() : String {
			return _data;
		}

		public function get bitmapdata() : BitmapData {
			return _bitmapdata;
		}
	}
}
