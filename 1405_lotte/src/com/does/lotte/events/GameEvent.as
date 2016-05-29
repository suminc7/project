package com.does.lotte.events {
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class GameEvent extends Event {
		public static const SUCCESS : String = "SUCCESS";
		public static const FAILED : String = "FAILED";
		public static const NEXT_STAGE : String = "NEXT_STAGE";
		public static const EAT_HEART_END : String = "EAT_HEART_END";
		public static const EAT_FRIEND_END : String = "EAT_FRIEND_END";
		public static const EAT_FRIEND : String = "EAT_FRIEND";
		public static const MINUS_LIFE : String = "MINUS_LIFE";
		public static const MINUS_LIFE_ANI_COMPLETE : String = "MINUS_LIFE_ANI_COMPLETE";
		public static const INIT_GAME : String = "INIT_GAME";
		public static const FRIEND_SELECT : String = "FRIEND_SELECT";
		public static const FRIEND_UNSELECT : String = "FRIEND_UNSELECT";
		public static const INVITE_FRIEND_COMPLETE : String = "INVITE_FRIEND_COMPLETE";
		public static const INVITE_FRIEND_FB_LOGIN : String = "INVITE_FRIEND_FB_LOGIN";
		public static const INVITE_FRIEND_TW_LOGIN : String = "INVITE_FRIEND_TW_LOGIN";
		public static const FINISHED_HOWTOCONTROL : String = "FINISHED_HOWTOCONTROL";
		public static const KEY_UP : String = "KEY_UP";
		public static const KEY_DOWN : String = "KEY_DOWN";
		public static const KEY_LEFT : String = "KEY_LEFT";
		public static const KEY_RIGHT : String = "KEY_RIGHT";
		public static const MAIN_LOADING_COMPLETE : String = "MAIN_LOADING_COMPLETE";
		public static const IM_HERE_COMPLETE : String = "IM_HERE_COMPLETE";

		public function GameEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}
	}
}
