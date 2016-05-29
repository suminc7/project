package com.framework.loader {
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;

	import com.framework.debug.Debug;

	/**
	 * @author kylekaturn (http://kyle-katurn.com)
	 * @class : AbstractURLLoader.as
	 * @write_date : 2008. 05. 08
	 * @version : V1.0
	 */
	public class AbstractURLLoader extends URLLoader {
		public function AbstractURLLoader() {
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			addEventListener(Event.OPEN, openHandler);
		}

		// ____________________________________________________________ event handler
		private function openHandler(event : Event) : void {
			Debug.tracer("openHandler: " + event);
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			Debug.tracer("securityErrorHandler: " + event);
		}

		private function httpStatusHandler(event : HTTPStatusEvent) : void {
			Debug.tracer("httpStatusHandler: " + event);
		}

		private function ioErrorHandler(event : IOErrorEvent) : void {
			Debug.tracer("ioErrorHandler: " + event);
		}
	}
}
