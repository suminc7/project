package com.does.lotte.object.maps {
	import com.does.lotte.abstract.MapObject;
	import com.does.lotte.interfaces.IMap;
	import com.does.lotte.types.KeyType;

	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class Map2 extends MapObject implements IMap {
		public static const tx : int = 11;
		public static const ty : int = 2;

		public function Map2() {
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			init();
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			start();
		}

		private function initRemoveStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function init() : void {
			mapStr = "";
			mapStr += "000000000000000000000000";
			mapStr += "000000000000800000000000";
			mapStr += "000000000000100000000000";
			mapStr += "000000011111111110000000";
			mapStr += "000000010010001010000000";
			mapStr += "000011110011111110000000";
			mapStr += "000010010010001010000000";
			mapStr += "000011111111103011110000";
			mapStr += "000010001010101000010000";
			mapStr += "000010001011111111110000";
			mapStr += "041110001000100100011140";
			mapStr += "000011111111100100010000";
			mapStr += "000010001000111111130000";
			mapStr += "000031111111100001000000";
			mapStr += "000000010000100001000000";
			mapStr += "000000010011111001000000";
			mapStr += "000000011110001111000000";
			mapStr += "000000000010001000000000";
			mapStr += "000000000011111000000000";
			mapStr += "000000000000000000000000";

			hGrid = 20;
			vGrid = 24;
		}

		private function start() : void {
		}

		override protected function teleport(ax : int, ay : int) : void {
			// if (ax == 1 && ay == 10 && char.getType() == KeyType.LEFT) {
			// char.setType(KeyType.LEFT);
			// char.setPosition(22, 10, 0);
			// } else if (ax == 22 && ay == 10 && char.getType() == KeyType.RIGHT) {
			// char.setType(KeyType.RIGHT);
			// char.setPosition(1, 10, 0);
			// }

			if (ax == 1 && ay == 10 && char.getType() == KeyType.DOWN) {
				char.setType(KeyType.DOWN);
				char.setPosition(22, 10, 0);
			} else if (ax == 22 && ay == 10 && char.getType() == KeyType.UP) {
				char.setType(KeyType.UP);
				char.setPosition(1, 10, 0);
			}
		}
	}
}
