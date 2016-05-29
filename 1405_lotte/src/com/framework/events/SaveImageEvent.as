package com.framework.events {
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class SaveImageEvent extends Event {
		public static const SAVE_IMAGE_PROGRESS : String = "SAVE_IMAGE_PROGRESS";
		public static const SAVE_IMAGE_ERROR : String = "SAVE_IMAGE_ERROR";
		public static const SAVE_CYWORLD_IMAGE_COMPLETE : String = "SAVE_CYWORLD_IMAGE_COMPLETE";
		public static const SAVE_IMAGE_COMPLETE : String = "SAVE_IMAGE_COMPLETE";

		public function SaveImageEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles);
			return;
		}
	}
}
