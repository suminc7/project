package com.does.lotte.pacman.steps {
	import com.does.lotte.global.User;
	import com.does.lotte.events.GameEvent;
	import com.greensock.TweenMax;

	import flash.events.MouseEvent;

	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.ImageLoader;

	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author chaesumin
	 */
	public class InviteFriendItem extends Sprite {
		public var nameTxt : TextField;
		public var mc : Sprite;
		public var border : Sprite;
		private var isClick : Boolean;
		private var _id : String;
		private var _myname : String;

		public function InviteFriendItem() {
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
			nameTxt.text = "";
			nameTxt.autoSize = TextFieldAutoSize.CENTER;
		}

		private function start() : void {
			buttonMode = true;
			addEventListener(MouseEvent.MOUSE_OVER, thisOver);
			addEventListener(MouseEvent.MOUSE_OUT, thisOut);
			addEventListener(MouseEvent.CLICK, thisClick);
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 64, 120);
			graphics.endFill();
		}

		private function thisOver(event : MouseEvent) : void {
			if (!isClick) {
				TweenMax.to(border, 0.3, {tint:0x999999});
			}
		}

		private function thisOut(event : MouseEvent) : void {
			if (!isClick) {
				TweenMax.to(border, 0.3, {tint:0xcccccc});
			}
		}

		private function thisClick(event : MouseEvent) : void {
			if (isClick) {
				off();
			} else {
				on();
			}
		}

		public function on() : void {
			TweenMax.to(border, 0.3, {tint:0xFF4941});
			isClick = true;
			dispatchEvent(new GameEvent(GameEvent.FRIEND_SELECT, true));
		}

		public function off() : void {
			TweenMax.to(border, 0.3, {tint:0xcccccc});
			isClick = false;
			dispatchEvent(new GameEvent(GameEvent.FRIEND_UNSELECT, true));
		}

		public function setItem(data : Object) : void {
			nameTxt.text = data["name"];
			id = data["id"];
			myname = data["name"];

			var loader : ImageLoader = new ImageLoader(data.picture.data.url, {name:"photo1", container:mc, x:0, y:0, width:64, height:64, onComplete:onImageLoad});
			loader.load();

			function onImageLoad(event : LoaderEvent) : void {
			}
		}

		public function get id() : String {
			return _id;
		}

		public function set id(id : String) : void {
			_id = id;
		}

		public function get myname() : String {
			return _myname;
		}

		public function set myname(myname : String) : void {
			_myname = myname;
		}
	}
}
