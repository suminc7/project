package com.does.lotte.object.monster {
	import com.does.lotte.abstract.MovingObject;
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.interfaces.IMap;
	import com.does.lotte.object.character.Character;
	import com.does.lotte.object.maps.MapData;
	import com.does.lotte.types.KeyType;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;

	/**
	 * @author chaesumin
	 */
	public class Monster1 extends MovingObject {
		public var mc : MovieClip;
		private var posArr : Array = [{check:upCheck, type:KeyType.UP, way:"V"}, {check:downCheck, type:KeyType.DOWN, way:"V"}, {check:leftCheck, type:KeyType.LEFT, way:"H"}, {check:rightCheck, type:KeyType.RIGHT, way:"H"}];
		private var char : Character;
		private var isEatFriend : Boolean;
		private var isSuccess : Boolean;
		private var time : Timer;

		public function Monster1(map : IMap, char : Character) {
			this.char = char;
			mapArr = map.getMapData();

			addEventListener(Event.ADDED_TO_STAGE, initAddStage);
			addEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			init();
		}

		private function initAddStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, initAddStage);
			start();
		}

		private function initRemoveStage(event : Event) : void {
			removeListener();
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
		}

		private function init() : void {
			stop();
			mc.gotoAndStop(1);
		}

		private function start() : void {
			addListener();
		}

		private function addListener() : void {
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(GameEvent.SUCCESS, successListener);
			stage.addEventListener(GameEvent.FAILED, failedListener);
			stage.addEventListener(GameEvent.EAT_FRIEND, eatFriendListener);
			stage.addEventListener(GameEvent.EAT_FRIEND_END, eatFriendEndListener);
		}

		private function removeListener() : void {
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			stage.removeEventListener(GameEvent.SUCCESS, successListener);
			stage.removeEventListener(GameEvent.FAILED, failedListener);
			stage.removeEventListener(GameEvent.EAT_FRIEND, eatFriendListener);
			stage.removeEventListener(GameEvent.EAT_FRIEND_END, eatFriendListener);
		}

		private function eatFriendEndListener(event : GameEvent) : void {
		}

		private function eatFriendListener(event : GameEvent) : void {
			isEatFriend = true;

			mc.gotoAndPlay("n1");

			if (time) time.reset();
			time = new Timer(Character.eatFriendTime, 1);
			time.addEventListener(TimerEvent.TIMER_COMPLETE, timeComplete);
			time.start();

			SoundController.instance(root).volumeDown();
			char.upMovingTime();
		}

		private function timeComplete(event : TimerEvent) : void {
			isEatFriend = false;
			mc.gotoAndStop(1);
			gotoTailMap(ax, ay, type);

			SoundController.instance(root).volumeUp();
			char.downMovingTime();
		}

		private function failedListener(event : GameEvent) : void {
			TweenMax.killTweensOf(this);
			isSuccess = true;
			removeListener();
			if (time) time.reset();
		}

		private function successListener(event : GameEvent) : void {
			TweenMax.killTweensOf(this);
			isSuccess = true;
			removeListener();
			if (time) time.reset();
		}

		private function enterFrame(event : Event) : void {
			var nx : int = Math.abs(x - char.x);
			var ny : int = Math.abs(y - char.y);

			// trace('nx: ' + (nx));
			// trace('ny: ' + (ny));
			// 친구먹는 상태면 생명력은 그대로..
			if (nx < 30 && ny < 15 && !isEatFriend) {
				char.minusLife();
			}
		}

		public function startGame() : void {
			gotoTailMap(ax, ay, type);
		}

		override public function setPosition(nax : int, nay : int, time : Number = 0) : void {
			var point : Point = MapData.getTilePosition(nax, nay);
			if (!isTween) {
				isTween = true;

				frameCheck(type);

				time = Math.abs(point.x - x) / MapData.bw * time;

				var obj : Object;
				// 처음실행시는 time=0 이다 그래서 위치만 변경시킨다.
				if (time == 0) {
					obj = {x:point.x, y:point.y};
					setData(type, nax, nay);
				} else {
					obj = {x:point.x, y:point.y, ease:Linear.easeNone, onComplete:gotoTailMap, onCompleteParams:[nax, nay, type]};
				}

				TweenMax.to(this, time, obj);
			}
		}

		private function gotoTailMap(nax : int, nay : int, ntype : String) : void {
			// trace('isTween: ' + (isTween));

			// 성공하면 멈추기.
			if (isSuccess) return;

			setData(ntype, nax, nay);

			// 친구 먹는상태면 멈춰있기때문에 아래 실행 불가
			if (isEatFriend) {
				return;
			}

			var i : int;
			var arr : Array = [];
			var obj : Object = {};
			var splice : Array;

			// 랜덤하게 순서 변경.
			arr = posArr.concat();
			var pos : Array = [];

			for (i = 0; i < 4; i++) {
				var n : int = Math.floor(Math.random() * arr.length);
				pos.push(arr[n]);
				arr.splice(n, 1);
			}

			// 세로 위치를 체크해 따라다니게 정하기.
			var charPos : Point = char.getPosition();
			// trace('ax: ' + (ax));
			// trace('charPos.x: ' + (charPos.x));
			if (ax > charPos.x && obj.type == KeyType.DOWN) {
				for (i = 0; i < 4; i++) {
					obj = pos[i];
					splice = pos.splice(i, 1);
					pos.unshift(splice[0]);
					break;
				}
			} else if (ax < charPos.x && obj.type == KeyType.UP) {
				for (i = 0; i < 4; i++) {
					obj = pos[i];
					splice = pos.splice(i, 1);
					pos.unshift(splice[0]);
					break;
				}
			} else if ( ax == charPos.x && Math.random() > 0.5) {
				// 가로가 같으면 세로로 이동하고 0.5보다 컸을때만.
				if (ay < charPos.y) {
					for (i = 0; i < 4; i++) {
						obj = pos[i];
						if (obj.type == KeyType.RIGHT) {
							splice = pos.splice(i, 1);
							pos.unshift(splice[0]);
							break;
						}
					}
				} else {
					for (i = 0; i < 4; i++) {
						obj = pos[i];
						if (obj.type == KeyType.LEFT) {
							splice = pos.splice(i, 1);
							pos.unshift(splice[0]);
							break;
						}
					}
				}
			}

			// 뒤로가는건 배열 제일 뒤로..
			for (i = 0; i < 4; i++) {
				obj = pos[i];
				if (way == obj.way && type != obj.type) {
					pos.push(pos.splice(i, 1)[0]);
					break;
				}
			}

			// 갈수 있으면 이동한다.
			for (i = 0; i < 4; i++) {
				obj = pos[i];

				if (obj.check.call()) {
					type = obj.type;
					break;
				}
			}

			keyCheck(type);
		}
	}
}
