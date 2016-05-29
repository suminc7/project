package com.does.lotte.abstract {
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.global.Score;
	import com.does.lotte.object.character.Character;
	import com.does.lotte.object.maps.Friends;
	import com.does.lotte.object.maps.Heart;
	import com.does.lotte.object.maps.MapData;
	import com.does.lotte.pacman.ui.FriendsView;
	import com.does.lotte.pacman.ui.HeartView;
	import com.does.lotte.pacman.ui.ScoreView;
	import com.does.lotte.pacman.ui.TimerView;
	import com.framework.math.MathUtils;
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	/**
	 * @author chaesumin
	 */
	public class MapObject extends Sprite {
		public var timerCount : Number = 0;
		public var totalTimerCount : int = 120;
		protected var arr : Array;
		protected var char : Character;
		protected var mapStr : String;
		protected var hGrid : int;
		protected var vGrid : int;
		private var totalHeart : int;
		private var totalFriends : int;
		private var myHeart : int;
		private var myFriend : int;
		private var myScore : int;
		private var heartView : HeartView;
		private var scoreView : ScoreView;
		private var friendView : FriendsView;
		private var timerView : TimerView;

		public function MapObject() {
			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			init();
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			start();
		}

		private function initRemoveStage(event : Event) : void {
			stage.removeEventListener(GameEvent.FAILED, failed);
			stage.removeEventListener(GameEvent.SUCCESS, success);
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function init() : void {
		}

		private function start() : void {
			initMap();
			initHeart();

			stage.addEventListener(GameEvent.FAILED, failed);
			stage.addEventListener(GameEvent.SUCCESS, success);
		}

		private function failed(event : GameEvent) : void {
			TweenMax.killTweensOf(this);
		}

		private function success(event : GameEvent) : void {
			TweenMax.killTweensOf(this);
		}

		/*
		 * 하트와 친구배치 / 하트는 1, 친구는 3
		 */
		private function initHeart() : void {
			var point : Point;

			for (var i : int = 0;i < hGrid;i++) {
				for (var j : int = 0;j < vGrid;j++) {
					if (arr[i][j] == "1") {
						point = MapData.getTilePosition(j, i);
						var heart : Heart = new Heart();
						heart.name = "h_" + j + "_" + i;
						heart.x = point.x;
						heart.y = point.y;
						addChild(heart);
						totalHeart++;
					} else if (arr[i][j] == "3") {
						point = MapData.getTilePosition(j, i);
						var friend : Friends = new Friends();
						friend.name = "f_" + j + "_" + i;
						friend.x = point.x;
						friend.y = point.y;
						addChild(friend);
						totalFriends++;
					}
				}
			}

			updateHeart();
			updateFriends();
		}

		/*
		 * 배열에서 그리드에 맞게 지도 자르
		 */
		private function initMap() : void {
			arr = new Array();

			for (var i : int = 0;i < hGrid;i++) {
				var ss : String = mapStr.substr(vGrid * i, vGrid);
				var splitArr : Array = ss.split("");
				arr.push(splitArr);
			}
		}

		public function getMapData() : Array {
			return arr;
		}

		/*
		 * 지도 체크 / 4 : teleport, 1 : heart, 3 : friend
		 */
		public function checkMap(ax : int, ay : int) : void {
			if (arr[ay][ax] == "4") {
				teleport(ax, ay);
			} else if (arr[ay][ax] == "1") {
				arr[ay][ax] = "2";
				removeHeart(ax, ay);
			} else if (arr[ay][ax] == "3") {
				arr[ay][ax] = "9";
				removeFriends(ax, ay);
			}
		}

		public function removeHeart(ax : int, ay : int) : void {
			var obj : Heart = getChildByName("h_" + ax + "_" + ay) as Heart;
			if (obj) {
				obj.play();
				obj.addEventListener(GameEvent.EAT_HEART_END, eatHeartListener);

				updateScore(Score.heartScore);
				myHeart++;
				updateHeart();

				SoundController.instance(root).eatingHeart();
				// 하트를 다 먹고 성공했을때.
				if (myHeart == totalHeart) {
					dispatchEvent(new GameEvent(GameEvent.SUCCESS, true));
				}
			}
		}

		private function eatHeartListener(event : GameEvent) : void {
			var obj : Heart = event.currentTarget as Heart;
			obj.removeEventListener(GameEvent.EAT_HEART_END, eatHeartListener);
			removeChild(obj);
			obj = null;
		}

		private function updateHeart() : void {
			var str : String = myHeart + " / " + totalHeart;
			heartView.setHeart(str);

			Score.myHeart = myHeart;
		}

		public function removeFriends(ax : int, ay : int) : void {
			var obj : Friends = getChildByName("f_" + ax + "_" + ay) as Friends;
			if (obj) {
				obj.playFriend();
				obj.addEventListener(GameEvent.EAT_FRIEND_END, eatFriendListener);

				updateScore(Score.friendScore);
				myFriend++;
				updateFriends();

				SoundController.instance(root).eatingFriend();
				SoundController.instance(root).invincible();
			}
		}

		private function eatFriendListener(event : GameEvent) : void {
			var obj : Friends = event.currentTarget as Friends;
			obj.removeEventListener(GameEvent.EAT_FRIEND_END, eatFriendListener);
			removeChild(obj);
			obj = null;
		}

		private function updateFriends() : void {
			var str : String = myFriend + " / " + totalFriends;
			friendView.setFriend(str);

			Score.myFriend = myFriend;
		}

		private function updateScore(n : int) : void {
			myScore += n;
			scoreView.setScore(MathUtils.putComma(myScore));
		}

		protected function teleport(ax : int, ay : int) : void {
		}

		public function startGame() : void {
			startTimer();
		}

		private function startTimer() : void {
			// x:368
			TweenMax.to(this, totalTimerCount, {timerCount:totalTimerCount, onUpdate:onUpdate, onComplete:onComplete});

			function onUpdate() : void {
				timerView.setTime(timerCount / totalTimerCount);

				Score.myTime = Math.round((totalTimerCount - timerCount) * 100) / 100;
			}
			function onComplete() : void {
				dispatchEvent(new GameEvent(GameEvent.FAILED, true));
			}
		}

		public function setHeartView(heartView : HeartView) : void {
			this.heartView = heartView;
		}

		public function setCharacter(char : Character) : void {
			this.char = char;
		}

		public function setScoreView(view : ScoreView) : void {
			this.scoreView = view;
		}

		public function setFriendsView(view : FriendsView) : void {
			this.friendView = view;
		}

		public function setTimerView(view : TimerView) : void {
			this.timerView = view;
		}
	}
}
