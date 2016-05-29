package com.does.lotte.global {
	import flash.external.ExternalInterface;
	/**
	 * @author chaesumin
	 */
	public class Tracking {

		public static function track(action : String, type : String) : void {
			
			//Tracking.track("click", "Game_Start");
			ExternalInterface.call("GAME.track", action, type);

		}

	}
}
