package com.framework.loader {
	import com.framework.debug.Debug;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.text.TextField;

	/**
	 * @author kylekaturn (http://kyle-katurn.com)
	 * @class : SmoothLoader.as
	 * @write_date : 2009. 3. 31.
	 * @version : V1.0
	 */
	public class SmoothLoader extends MovieClip {
		public static var ON_PLAY_FINISHED : String = "onPlayFinished";
		public var content : Bitmap;
		private var loader : Loader;
		private var bitmapData : BitmapData;
		private var UrlObj : URLRequest;
		private var progressBar : DisplayObject;
		private var progressText : TextField;
		private var progressMovieClip : MovieClip;

		/**
		 * swf 파일을 로드함
		 * @param url	swf 파일 url 
		 */
		public function loadImage(url : String) : void {
			Debug.tracer(url + " : file loading has started.", null, Debug.LEVEL_INFO);

			loader = new Loader();

			UrlObj = new URLRequest(url);

			loader.load(UrlObj, new LoaderContext(true, ApplicationDomain.currentDomain));

			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleted);
			loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
		}

		/**
		 * dispose
		 */
		public function dispose() : void {
			loader.unload();
		}

		/**
		 * loading Progress 
		 */
		private function onLoadingProgress(event : ProgressEvent) : void {
			var percentage : Number = (event.bytesLoaded / event.bytesTotal) * 100;
			if (progressBar) {
				progressBar.scaleX = percentage / 100;
			}
			if (progressText) {
				progressText.text = String(int(percentage));
			}
			if (progressMovieClip) {
				progressMovieClip.gotoAndStop(Math.floor((percentage / 100) * progressMovieClip.totalFrames));
			}
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, event.bytesLoaded, event.bytesTotal));
		}

		/**
		 * Complete Event Handler
		 */
		private function onLoadCompleted(event : Event) : void {
			Debug.tracer(UrlObj.url + " : file loading has completed.", null, Debug.LEVEL_INFO);
			bitmapData = new BitmapData(loader.content.width, loader.content.height, true, 0xFFFFFF);
			bitmapData.draw(loader.content);
			content = new Bitmap(bitmapData);
			content.smoothing = true;
			addChild(content);

			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * IO Error handler
		 */
		private function onIOError(event : IOErrorEvent) : void {
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
			Debug.tracer(event.text, null, Debug.LEVEL_ERROR);
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
		}

		/**
		 * on Inited 
		 */
		private function onInit(event : Event) : void {
			dispatchEvent(new Event(Event.INIT));
		}
	}
}
