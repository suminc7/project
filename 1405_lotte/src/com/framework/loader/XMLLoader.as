package com.framework.loader {
	import com.framework.debug.Debug;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.net.URLVariables;

	/**
	 * XML 파일 로더 클래스
	 * @author : kylekaturn (http://kyle-katurn.com)
	 * @class : XMLLoader.as
	 * @write_date : 2008. 02. 01
	 * @version : V1.0
	 */
	public class XMLLoader extends EventDispatcher {
		private var url : String;
		private var request : URLRequest;
		private var encode : String;
		private var xmlData : XML;
		private var loader : URLStream;

		public function XMLLoader() {
			loader = new URLStream();
		}

		/**
		 * xml 파일을 로드
		 * @param url	XML url
		 */
		public function loadXML(url : String, encode : String = "UTF-8", urlVariables : URLVariables = null, method : String = URLRequestMethod.GET) : void {
			this.encode = encode;
			this.url = url;
			request = new URLRequest(url);
			request.data = urlVariables;
			request.method = method;

			Debug.tracer(url + " : file loading has started.", null, Debug.LEVEL_INFO);
			loader.addEventListener(Event.COMPLETE, onComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loadFailSecurity);
			loader.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.load(request);
		}

		private function loadFailSecurity(event : SecurityErrorEvent) : void {
			dispatchEvent(new SecurityErrorEvent(SecurityErrorEvent.SECURITY_ERROR));
		}

		private function loadProgress(event : ProgressEvent) : void {
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
		}

		/**
		 * return xml
		 */
		public function get xml() : XML {
			return xmlData;
		}

		public function close() : void {
			if (loader.connected) {
				loader.close();
			}
		}

		/**************************************************************************
		 * event handler
		 ***************************************************************************/
		/**
		 * Complete event handler
		 */
		private function onComplete(event : Event) : void {
			Debug.tracer(url + " : file loading has Completed.", null, Debug.LEVEL_INFO);
			xmlData = new XML(loader.readMultiByte(loader.bytesAvailable, encode));
			dispatchEvent(new Event(Event.COMPLETE));
		}

		/**
		 * IO Error handler
		 */
		private function onIOError(event : IOErrorEvent) : void {
			Debug.inspect(event);
			dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR));
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
			Debug.tracer(url + " onIOError : " + event.text, null, Debug.LEVEL_ERROR);
			Debug.tracer("-----------------------------------------------------------", null, Debug.LEVEL_ERROR);
		}
	}
}
