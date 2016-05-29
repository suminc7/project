package com.framework.events {
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class NavigationEvent extends Event {
		public static const OVER : String = "OVER";
		public static const OUT : String = "OUT";
		public static const CLICK : String = "CLICK";
		public var a : int;

		public function NavigationEvent(type : String, bubbles : Boolean = false, a : int = -1, cancelable : Boolean = false) {
			this.a = a;
			super(type, bubbles);
			return;
		}
	}
}
