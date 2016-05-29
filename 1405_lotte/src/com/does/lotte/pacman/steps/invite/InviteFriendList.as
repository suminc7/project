package com.does.lotte.pacman.steps.invite {
	import com.framework.math.Rnd;
	import com.framework.math.MathUtils;
	import com.does.lotte.global.GameData;
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.global.Tracking;
	import com.does.lotte.global.User;
	import com.does.lotte.pacman.steps.InviteFriendItem;
	import com.does.lotte.pacman.steps.SendData;
	import com.framework.serialization.json.JSON;
	import com.framework.types.ScrollType;
	import com.framework.ui.scroller.Scroller;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;

	/**
	 * @author chaesumin
	 */
	public class InviteFriendList extends Sprite {
		private var friendItem : InviteFriendItem;
		public var inviteBtn : Sprite;
		public var mc : Sprite;

		public function InviteFriendList() {
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
			ExternalInterface.addCallback("setFriends", setFriends);

			mc = new Sprite();
			mc.x = 4;
			mc.y = 57;
			addChild(mc);

			addEventListener(GameEvent.FRIEND_SELECT, friendSelectListener);
			addEventListener(GameEvent.FRIEND_UNSELECT, friendUnSelectListener);

			inviteBtn.buttonMode = true;
			inviteBtn.addEventListener(MouseEvent.CLICK, inviteBtnClick);
			BtnController.down(MovieClip(inviteBtn));
		}

		private function inviteBtnClick(event : MouseEvent) : void {
			if (friendItem) {
				Tracking.track("click", "Game_St" + GameData.currentStep + "_Invite_Facebook");

				SendData.inviteFriend(User.inviteID, User.inviteName, callback);

				function callback(data : Object) : void {
					// if (data.result == "success") {
					dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_COMPLETE, true));
					// }
				}

				// dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_COMPLETE, true));
			} else {
			}
		}

		private function setFriends(response : String) : void {
			if (response) {
				var obj : Object = JSON.decode(response);
				
				var rndArr : Array = Rnd.rndNumber(obj.data.length);

				for (var i : int = 0;i < obj.data.length;i++) {
					var friend : InviteFriendItem = new InviteFriendItem();
					friend.setItem(obj.data[rndArr[i]]);
					friend.x = 75 * (i % 5);
					friend.y = 105 * Math.floor(i / 5);
					mc.addChild(friend);
				}

				var scroll : Scroller = new Scroller(stage, ScrollType.VERTICAL, mc, this["seekBar"], this["seekBtn"], 0);
				addChild(scroll);
			}
		}

		private function friendSelectListener(event : GameEvent) : void {
			if (friendItem && friendItem != InviteFriendItem(event.target)) {
				friendItem.off();
			}

			friendItem = InviteFriendItem(event.target);
			User.inviteID = friendItem.id;
			User.inviteName = friendItem.myname;
		}

		private function friendUnSelectListener(event : GameEvent) : void {
			friendItem = null;
			User.inviteID = "";
			User.inviteName = "";
		}
	}
}
