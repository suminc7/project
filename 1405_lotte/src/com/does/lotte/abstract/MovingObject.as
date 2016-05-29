package com.does.lotte.abstract {
	import com.does.lotte.types.KeyType;

	import flash.display.MovieClip;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class MovingObject extends MovieClip {
		protected var mapArr : Array;
		protected var ax : int;
		protected var ay : int;
		protected var type : String;
		protected var way : String;
		protected var isTween : Boolean;
		protected var beforeType : String;
		protected var movingTime : Number = 0.4;
		protected var nextAy : int;
		protected var nextAx : int;

		public function MovingObject() {
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
		}

		private function start() : void {
		}

		public function turnUp() : void {
			if (type == KeyType.DOWN) isTween = false;
			type = KeyType.UP;
			way = "V";
			if (upCheck()) {
				setUpPosition();
			} else {
			}
		}

		public function turnDown() : void {
			if (type == KeyType.UP) isTween = false;
			type = KeyType.DOWN;
			way = "V";
			if (downCheck()) {
				setDownPosition();
			} else {
			}
		}

		public function turnLeft() : void {
			if (type == KeyType.RIGHT) isTween = false;
			type = KeyType.LEFT;
			way = "H";
			if (leftCheck()) {
				setLeftPosition();
			} else {
			}
		}

		public function turnRight() : void {
			if (type == KeyType.LEFT) isTween = false;
			type = KeyType.RIGHT;
			way = "H";
			if (rightCheck()) {
				setRightPosition();
			} else {
			}
		}

		protected function keyCheck(type : String) : void {
			if (type == KeyType.UP) {
				turnUp();
			} else if (type == KeyType.DOWN) {
				turnDown();
			} else if (type == KeyType.LEFT) {
				turnLeft();
			} else if (type == KeyType.RIGHT) {
				turnRight();
			}
		}

		public function frameCheck(type : String) : void {
			if (type == KeyType.UP) {
				gotoAndStop(2);
			} else if (type == KeyType.DOWN) {
				gotoAndStop(4);
			} else if (type == KeyType.LEFT) {
				gotoAndStop(1);
			} else if (type == KeyType.RIGHT) {
				gotoAndStop(3);
			} else {
			}
		}

		private function get plusAX() : int {
			return ax + 1;
		}

		private function get minusAX() : int {
			return ax - 1;
		}

		private function get plusAY() : int {
			return ay + 1;
		}

		private function get minusAY() : int {
			return ay - 1;
		}

		protected  function upCheck() : Boolean {
			return mapArr[ay][plusAX] != "0";
		}

		protected function downCheck() : Boolean {
			return mapArr[ay][minusAX] != "0";
		}

		protected function leftCheck() : Boolean {
			return mapArr[minusAY][ax] != "0";
		}

		protected function rightCheck() : Boolean {
			return mapArr[plusAY][ax] != "0";
		}

		protected function setUpPosition() : void {
			setPosition(plusAX, ay, movingTime);
		}

		protected function setDownPosition() : void {
			setPosition(minusAX, ay, movingTime);
		}

		protected function setLeftPosition() : void {
			setPosition(ax, minusAY, movingTime);
		}

		protected function setRightPosition() : void {
			setPosition(ax, plusAY, movingTime);
		}

		protected function setData(ntype : String, nax : int, nay : int) : void {
			beforeType = ntype;
			ax = nax;
			ay = nay;
			isTween = false;
		}

		public function setPosition(nax : int, nay : int, time : Number = 0) : void {
		}
	}
}
