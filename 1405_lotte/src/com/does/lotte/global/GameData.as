package com.does.lotte.global {
	import flash.external.ExternalInterface;
	/**
	 * @author chaesumin
	 */
	public class GameData {
		private static var step : int = 1;
		
		

		public static function get currentStep() : int {
			return step;
		}

		public static function nextStep() : void {
			if (step == 1) {
				step = 2;
			} else if (step == 2) {
				step = 3;
			}
		}

		public static function replay() : void {
			step = 1;
		}

		public static function goJoin() : void {
			
			var url : String = ExternalInterface.call("login");

//			navigateToURL(new URLRequest(url), "_self");
			
		}
	}
}
