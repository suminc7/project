package com.framework.events {
	import flash.events.Event;

	/**
	 * @author sumin
	 */
	public class VideoLoaderEvent extends Event {
		public var obj : Object;
		public static const ON_NET_STREAM : String = "ON_NET_STREAM";
		public static const ON_NET_STREAM_PROGRESS : String = "ON_NET_STREAM_PROGRESS";
		public static const ON_PLAY_FINISHED : String = "ON_PLAY_FINISHED";
		public static const ON_PLAY_STARTED : String = "ON_PLAY_STARTED";
		public static const ON_META_DATA : String = "ON_META_DATA";
		public static const ON_XMP_DATA : String = "ON_XMP_DATA";
		public static const NETSTREAM_BUFFER_FULL : String = "NETSTREAM_BUFFER_FULL";
		public static const SEEK : String = "SEEK";

		public function VideoLoaderEvent(type : String, bubbles : Boolean = false, obj : Object = null, cancelable : Boolean = false) {
			this.obj = obj;
			super(type, bubbles);
			return;
		}
	}
}
