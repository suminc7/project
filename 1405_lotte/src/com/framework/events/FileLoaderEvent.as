package com.framework.events {
	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class FileLoaderEvent extends Event {
		public var obj : DisplayObject;
		public static const FILE_LOAD_COMPLETE : String = "FILE_LOAD_COMPLETE";

		public function FileLoaderEvent(type : String, bubbles : Boolean = false, obj : DisplayObject = null, cancelable : Boolean = false) {
			this.obj = obj;
			super(type, bubbles);
			return;
		}
	}
}
