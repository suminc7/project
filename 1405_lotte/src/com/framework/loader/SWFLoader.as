package com.framework.loader {
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

	import com.framework.debug.Debug;

	/**
	 * SWF 파일 Loader 클래스 
	 * flash.display.Loader 를 상속받아 swf 로딩, Progress , play 관련 처리 
	 * 
	 * @author : kylekaturn (http://kyle-katurn.com)
	 * @class : SwfLoader.as
	 * @write_date : 2008. 01. 30
	 * @version : V1.0
	 */
	public class SWFLoader extends Loader {
		public static var ON_PLAY_FINISHED : String = "onPlayFinished";
		private var UrlObj : URLRequest;
		private var progressBar : DisplayObject;
		private var progressText : TextField;
		private var progressMovieClip : MovieClip;

		/**
		 * swf 파일을 로드함
		 * @param url	swf 파일 url 
		 */
		public function loadSwf(url : String) : void {
			Debug.tracer(url + " : file loading has started.", null, Debug.LEVEL_INFO);

			UrlObj = new URLRequest(url);
			load(UrlObj, new LoaderContext(true, ApplicationDomain.currentDomain));

			contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadingProgress);
			contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadCompleted);
			contentLoaderInfo.addEventListener(Event.INIT, onInit);
		}

		/**
		 * dispose
		 */
		public function dispose() : void {
			removeEventListener(Event.ENTER_FRAME, update);
			unload();
		}

		/**
		 * 로딩처리가 될 진행바 오브젝트를 전달받음
		 * @param progressBar	로딩 처리될 displayObject
		 */
		public function setProgressBar(progressBar : DisplayObject) : void {
			this.progressBar = progressBar;
			progressBar.scaleX = 0;
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
			addEventListener(Event.ENTER_FRAME, update);
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
		 * update
		 */
		private function update(event : Event) : void {
			try {
				if (MovieClip(content).currentFrame == MovieClip(content).totalFrames) {
					dispatchEvent(new Event(SWFLoader.ON_PLAY_FINISHED));
					removeEventListener(Event.ENTER_FRAME, update);
				}
			} catch(e : *) {
			}
		}

		/**
		 * on Inited 
		 */
		private function onInit(event : Event) : void {
			dispatchEvent(new Event(Event.INIT));
		}
	}
}
