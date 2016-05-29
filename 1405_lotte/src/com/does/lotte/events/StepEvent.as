package com.does.lotte.events {
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class StepEvent extends Event {
		public static const HOWTOPLAY : String = "HOWTOPLAY";
		public static const STAGE_COUNT : String = "STAGE_COUNT";
		public static const INVITE_FRIEND : String = "INVITE_FRIEND";
		public static const START_GAME : String = "START_GAME";
		public static const REPLAY : String = "REPLAY";
		public static const STAGE_SCORE : String = "STAGE_SCORE";
		public static const ROULETTE_SCORE : String = "ROULETTE_SCORE";
		public static const ROULETTE_START : String = "ROULETTE_START";
		public static const ROULETTE_FIRST : String = "ROULETTE_FIRST";

		public static const MAIN : String = "MAIN";
		public static const EVENT_SUBMIT : String = "EVENT_SUBMIT";

		public function StepEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
