package com.framework.loader {
	import com.framework.debug.Debug;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.text.TextField;

	/**
	 * 
	 * @author : kylekaturn (http://kyle-katurn.com)
	 * @class : ImageLoader.as
	 * @write_date : 2008. 03. 06
	 * @version : V1.0
	 */
	public class ImageLoader extends Loader {
		private static var sequenceArray : Array;
		private var UrlObj : URLRequest;
		private var progressBar : DisplayObject;
		private var progressText : TextField;
		private var progressMovieClip : MovieClip;

		/**
		 * constructor method
		 */
		public function ImageLoader() {
		}

		public function loadImage(url : String) : void {
			// Debug.tracer(url + " : file loading has started.", null, Debug.LEVEL_INFO);

			var context : LoaderContext = new LoaderContext();
			context.checkPolicyFile = true;

			UrlObj = new URLRequest(url);
			load(UrlObj, context);
			contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadFailSecurity);
			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleted);
		}

		private function loadFailSecurity(event : SecurityErrorEvent) : void {
			dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));
		}

		/**
		 * 로딩처리가 될 진행바 오브젝트를 전달받음
		 * @param progressBar	로딩 처리될 displayObject
		 */
		public function setProgressBar(progressBar : DisplayObject) : void {
			this.progressBar = progressBar;
			progressBar.scaleX = 100;
		}

		/**
		 * 로딩 퍼센테이지를 표시할 TextField 를 전달받음
		 * @param progressText	로딩 퍼센테이지를 표시할 TextField
		 */
		public function setProgressText(progressText : TextField) : void {
			this.progressText = progressText;
			progressText.text = "";
		}

		/**
		 * 로딩에 맞춰서 frame 진행될 무비클립
		 * @param progressMovieClip
		 */
		public function setProgressMovieClip(progressMovieClip : MovieClip) : void {
			this.progressMovieClip = progressMovieClip;
			progressMovieClip.gotoAndStop(0);
		}

		/**
		 * 이미지 로딩 시작함
		 */
		private function startLoading(event : Event) : void {
		}

		/**
		 * loading Progress 
		 */
		private function onLoadingProgress(event : ProgressEvent) : void {
			var percentage : int = (event.bytesLoaded / event.bytesTotal) * 100;

			if (progressBar) {
				progressBar.scaleX = percentage;
			}

			if (progressText) {
				progressText.text = String(percentage);
			}

			if (progressMovieClip) {
				progressMovieClip.gotoAndStop(Math.floor(percentage / 100 * progressMovieClip.totalFrames));
			}
		}

		/**
		 * Complete Event Handler
		 */
		private function onLoadCompleted(event : Event) : void {
			// Debug.tracer(UrlObj.url + " : file loading has completed.", null, Debug.LEVEL_INFO);
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * IO Error handler
		 */
		private function onIOError(event : IOErrorEvent) : void {
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
			Debug.tracer(event.text, null, Debug.LEVEL_ERROR);
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
		}
	}
}
