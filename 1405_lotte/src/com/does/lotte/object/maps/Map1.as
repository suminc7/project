package com.does.lotte.object.maps {
	import com.does.lotte.abstract.MapObject;
	import com.does.lotte.interfaces.IMap;
	import com.does.lotte.types.KeyType;

	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class Map1 extends MapObject implements IMap {
		public static const tx : int = 11;
		public static const ty : int = 3;

		public function Map1() {
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
			mapStr += "000000000000000000000000";
			mapStr += "000000011111111110000000";
			mapStr += "000000010010010010000000";
			mapStr += "000000010010010010000000";
			mapStr += "000011110010010010000000";
			mapStr += "000010011111113111110000";
			mapStr += "000010010001000010010000";
			mapStr += "048111110001000010010000";
			mapStr += "000010010001110010011140";
			mapStr += "000010010001010010010000";
			mapStr += "000010010001111111130000";
			mapStr += "000031111111001001000000";
			mapStr += "000000010001001001000000";
			mapStr += "000000010001001001000000";
			mapStr += "000000011111111111000000";
			mapStr += "000000000000000000000000";
			mapStr += "000000000000000000000000";

			hGrid = 18;
			vGrid = 24;
		}

		private function start() : void {
		}

		override protected function teleport(ax : int, ay : int) : void {
			// if (ax == 1 && ay == 8 && char.getType() == KeyType.LEFT) {
			// char.setType(KeyType.LEFT);
			// char.setPosition(22, 9, 0);
			// } else if (ax == 22 && ay == 9 && char.getType() == KeyType.RIGHT) {
			// char.setType(KeyType.RIGHT);
			// char.setPosition(1, 8, 0);
			// }

			if (ax == 1 && ay == 8 && char.getType() == KeyType.DOWN) {
				char.setType(KeyType.DOWN);
				char.setPosition(22, 9, 0);
			} else if (ax == 22 && ay == 9 && char.getType() == KeyType.UP) {
				char.setType(KeyType.UP);
				char.setPosition(1, 8, 0);
			}
		}
	}
}
