package com.does.lotte.events {
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class InOutMotionEvent extends Event {
		public var a : int;
		public static const IN_MOTION_START : String = "IN_MOTION_START";
		public static const OUT_MOTION_START : String = "OUT_MOTION_START";
		public static const IN_MOTION_COMPLETE : String = "IN_MOTION_COMPLETE";
		public static const OUT_MOTION_COMPLETE : String = "OUT_MOTION_COMPLETE";

		public function InOutMotionEvent(type : String, bubbles : Boolean = false, a : int = -1, cancelable : Boolean = false) {
			this.a = a;
			super(type, bubbles);
			return;
		}
	}
}
