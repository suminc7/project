package com.framework.youtube {
	import flash.events.Event;

	/**
	 * @author zt
	 */
	public class YoutubeStatusEvent extends Event {
		public static const PLAYERSTATUS : String = "playerStatus";
		public var status : String;
		public var progress : Number;
		public var fullness : Number;
		public var sound : Number;

		public function YoutubeStatusEvent(type : String, bubbles : Boolean = false, status : String = "", progress : Number = 0, fullness : Number = 0, sound : Number = 1, cancelable : Boolean = false) {
			super(type, bubbles);
			this.status = status;
			this.progress = progress;
			this.fullness = fullness;
			this.sound = sound;
			return;
		}
	}
}
