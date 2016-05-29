package com.framework.events {
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class UiScrollEvent extends Event {
		public var num : Number;
		public var t : Number;
		public static const SCROLL_MOVE : String = "SCROLL_MOVE";

		public function UiScrollEvent(type : String, bubbles : Boolean = false, num : Number = 0, t : Number = 1, cancelable : Boolean = false) {
			this.num = num;
			this.t = t;
			super(type, bubbles);
			return;
		}
	}
}
