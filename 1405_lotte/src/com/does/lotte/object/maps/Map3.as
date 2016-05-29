package com.does.lotte.object.maps {
	import com.does.lotte.abstract.MapObject;
	import com.does.lotte.interfaces.IMap;
	import com.does.lotte.pacman.ui.FriendsView;
	import com.does.lotte.types.KeyType;

	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class Map3 extends MapObject implements IMap {
		public static const tx : int = 11;
		public static const ty : int = 1;
		private var friends : FriendsView;

		public function Map3() {
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
			mapStr += "000000000003110000000000";
			mapStr += "000000000000010000000000";
			mapStr += "000000008000010000000000";
			mapStr += "000000001000011111000000";
			mapStr += "000004111110010001000000";
			mapStr += "000000000010010001000000";
			mapStr += "000011111111111111110000";
			mapStr += "000000010000100001000000";
			mapStr += "000000010000100001000000";
			mapStr += "000111111000100001000000";
			mapStr += "000100001000100001111100";
			mapStr += "000100001111110000100100";
			mapStr += "000300000100011111100400";
			mapStr += "000000000100010000100000";
			mapStr += "000000000100010000100000";
			mapStr += "000000011100011111000000";
			mapStr += "000000000111110000000000";
			mapStr += "000000000001000000000000";
			mapStr += "000000000001000000000000";
			mapStr += "000000000001000000000000";
			mapStr += "000000000001300000000000";
			mapStr += "000000000000000000000000";

			hGrid = 23;
			vGrid = 24;
		}

		private function start() : void {
		}

		override protected function teleport(ax : int, ay : int) : void {
			if (ax == 5 && ay == 5 && char.getType() == KeyType.DOWN) {
				char.setType(KeyType.LEFT);
				char.setPosition(21, 13, 0);
			} else if (ax == 21 && ay == 13 && char.getType() == KeyType.RIGHT) {
				char.setType(KeyType.UP);
				char.setPosition(5, 5, 0);
			}
		}
	}
}
