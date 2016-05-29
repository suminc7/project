package com.framework.events {
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class MP3LoaderEvent extends Event {
		public var obj : Object;
		public static const ID3 : String = "ID3";
		public static const PLAY : String = "PLAY";
		public static const SOUND_COMPLETE : String = "SOUND_COMPLETE";
		public static const STOP : String = "STOP";
		public static const RESUME : String = "RESUME";
		public static const PAUSE : String = "PAUSE";
		public static const START : String = "START";
		public static const SEEK : String = "SEEK";

		public function MP3LoaderEvent(type : String, bubbles : Boolean = false, obj : Object = null, cancelable : Boolean = false) {
			this.obj = obj;
			super(type, bubbles);
			return;
		}
	}
}
