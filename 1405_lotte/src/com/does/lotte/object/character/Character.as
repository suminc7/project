package com.does.lotte.object.character {
	import com.does.lotte.abstract.MovingObject;
	import com.does.lotte.controller.SoundController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.interfaces.IMap;
	import com.does.lotte.object.maps.MapData;
	import com.does.lotte.pacman.steps.ImHere;
	import com.does.lotte.types.KeyType;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.geom.Point;

	/**
	 * @author chaesumin
	 */
	public class Character extends MovingObject {
		public static var life : int = 3;
		public static const eatFriendTime : Number = 5000;
		public var tx : int;
		public var ty : int;
		private var map : IMap;
		private var isFailed : Boolean;
		private var isLifeAnimation : Boolean;
		private var imHere : ImHere;

		public function Character(map : IMap) {
			this.map = map;
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
			removeEventListener(Event.REMOVED_FROM_STAGE, initRemoveStage);
			stage.removeEventListener(GameEvent.SUCCESS, successListener);
			stage.removeEventListener(GameEvent.FAILED, failedListener);
			removeEventListener(GameEvent.MINUS_LIFE_ANI_COMPLETE, minusLifeAniComplete);
			removeKeyListener();
		}

		private function init() : void {
			stop();
		}

		private function start() : void {
			stage.addEventListener(GameEvent.SUCCESS, successListener);
			stage.addEventListener(GameEvent.FAILED, failedListener);
			addEventListener(GameEvent.MINUS_LIFE_ANI_COMPLETE, minusLifeAniComplete);
		}

		public function startGame() : void {
			addKeyListener();

			initHere();
		}

		private function initHere() : void {
			imHere = new ImHere();
			imHere.y = -30;
			 imHere.addEventListener(GameEvent.IM_HERE_COMPLETE, imHereComplete);
			addChild(imHere);
			imHere.play();
		}

		private function imHereComplete(event : GameEvent) : void {
			imHere.removeEventListener(GameEvent.IM_HERE_COMPLETE, imHereComplete);
			removeChild(imHere);
			imHere = null;
		}

		private function addKeyListener() : void {
			stage.addEventListener(GameEvent.KEY_UP, keyUp);
			stage.addEventListener(GameEvent.KEY_DOWN, keyDown);
			stage.addEventListener(GameEvent.KEY_LEFT, keyLeft);
			stage.addEventListener(GameEvent.KEY_RIGHT, keyRight);
		}

		private function removeKeyListener() : void {
			stage.removeEventListener(GameEvent.KEY_UP, keyUp);
			stage.removeEventListener(GameEvent.KEY_DOWN, keyDown);
			stage.removeEventListener(GameEvent.KEY_LEFT, keyLeft);
			stage.removeEventListener(GameEvent.KEY_RIGHT, keyRight);
		}

		private function keyUp(event : GameEvent) : void {
			turnUp();
		}

		private function keyDown(event : GameEvent) : void {
			turnDown();
		}

		private function keyLeft(event : GameEvent) : void {
			turnLeft();
		}

		private function keyRight(event : GameEvent) : void {
			turnRight();
		}

		private function minusLifeAniComplete(event : GameEvent) : void {
			addKeyListener();
			isTween = false;

			setPosition(ax, ay, 0);
			frameCheck(type);
			minusLifeAnimation();
		}

		private function minusLifeAnimation() : void {
			TweenMax.to(this, 0, {alpha:0.5, delay:0});
			TweenMax.to(this, 0, {alpha:1.0, delay:0.3});
			TweenMax.to(this, 0, {alpha:0.5, delay:0.6});
			TweenMax.to(this, 0, {alpha:1.0, delay:0.9});
			TweenMax.to(this, 0, {alpha:0.5, delay:1.2});
			TweenMax.to(this, 0, {alpha:1.0, delay:1.5});
			TweenMax.to(this, 0, {alpha:0.5, delay:1.8});
			TweenMax.to(this, 0, {alpha:1.0, delay:2.1, onComplete:onComplete});

			function onComplete() : void {
				isLifeAnimation = false;
			}
		}

		private function successListener(event : GameEvent) : void {
			TweenMax.killTweensOf(this);
		}

		private function failedListener(event : GameEvent) : void {
			TweenMax.killTweensOf(this);
		}

		public function minusLife() : void {
			// ExternalInterface.call("console.log", 'life: ' + (life) + ', isLifeAnimation: ' + (isLifeAnimation));
			// trace("console.log", 'life: ' + (life) + ', isLifeAnimation: ' + (isLifeAnimation));

			if (life <= 0) {
				failed();
			} else {
				minus();
			}
		}

		private function minus() : void {
			if (isLifeAnimation) return;
			isLifeAnimation = true;
			TweenMax.killTweensOf(this);
			removeKeyListener();
			dispatchEvent(new GameEvent(GameEvent.MINUS_LIFE, true));
			gotoAndPlay("minus_life");
			life--;
			trace('life: ' + (life));

			SoundController.instance(root).minusLifeSound();
		}

		public function failed() : void {
			if (isFailed) return;
			isFailed = true;
			TweenMax.killTweensOf(this);
			removeKeyListener();
			dispatchEvent(new GameEvent(GameEvent.FAILED, true));
			gotoAndPlay("failed");

			SoundController.instance(root).failedSound();
		}

		public function getType() : String {
			return type;
		}

		public function setType(type : String) : void {
			this.type = type;
		}

		public function getPosition() : Point {
			return new Point(ax, ay);
		}

		override public function setPosition(nax : int, nay : int, time : Number = 0) : void {
			var point : Point = MapData.getTilePosition(nax, nay);
			if (!isTween) {
				isTween = true;

				nextAx = nax;
				nextAy = nay;

				frameCheck(type);

				time = Math.abs(point.x - x) / MapData.bw * time;

				var obj : Object;
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
			setData(ntype, nax, nay);

			nextAx = 0;
			nextAy = 0;

			map.checkMap(ax, ay);

			if (type == KeyType.UP) {
				if (upCheck()) {
					turnUp();
				} else {
					keyCheck(ntype);
				}
			} else if (type == KeyType.DOWN) {
				if (downCheck()) {
					turnDown();
				} else {
					keyCheck(ntype);
				}
			} else if (type == KeyType.LEFT) {
				if (leftCheck()) {
					turnLeft();
				} else {
					keyCheck(ntype);
				}
			} else if (type == KeyType.RIGHT) {
				if (rightCheck()) {
					turnRight();
				} else {
					keyCheck(ntype);
				}
			}
		}

		public function upMovingTime() : void {
			movingTime = .3;
		}

		public function downMovingTime() : void {
			movingTime = .4;
		}
	}
}
