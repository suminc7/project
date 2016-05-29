package com.does.lotte.pacman.steps.invite {
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.global.GameData;
	import com.does.lotte.global.Tracking;
	import com.does.lotte.pacman.steps.SendData;
	import com.framework.string.StringUtils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author chaesumin
	 */
	public class InviteFriendTweet extends Sprite {
		public var inviteBtn : Sprite;
		public var txt : TextField;
		public var lenTxt : TextField;

		public function InviteFriendTweet() {
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
			txt.removeEventListener(KeyboardEvent.KEY_DOWN, keyFocusChange);
		}

		private function init() : void {
			lenTxt.autoSize = TextFieldAutoSize.RIGHT;
		}

		private function start() : void {
			inviteBtn.buttonMode = true;
			inviteBtn.addEventListener(MouseEvent.CLICK, inviteBtnClick);
			BtnController.down(MovieClip(inviteBtn));

			keyFocusChange(null);
			txt.addEventListener(KeyboardEvent.KEY_DOWN, keyFocusChange);
		}

		private function keyFocusChange(event : KeyboardEvent) : void {
			lenTxt.text = txt.text.length + "/ 140";
		}

		private function inviteBtnClick(event : MouseEvent) : void {
			// dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_COMPLETE, true));
			
			Tracking.track("click", "Game_St" + GameData.currentStep + "_Invite_Twitter");

			var str : String = txt.text;

			str = StringUtils.striptags(str);
			str = StringUtils.removeNewLine(str);

			SendData.updateStatus(str, callback);

			function callback(data : Object) : void {
				dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_COMPLETE, true));
			}
		}
	}
}
