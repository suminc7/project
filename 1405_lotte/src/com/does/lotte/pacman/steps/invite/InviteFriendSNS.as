package com.does.lotte.pacman.steps.invite {
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.GameEvent;
	import com.framework.serialization.json.JSON;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;

	/**
	 * @author chaesumin
	 */
	public class InviteFriendSNS extends Sprite {
		public var fbBtn : Sprite;
		public var twBtn : Sprite;

		public function InviteFriendSNS() {
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
			fbBtn.buttonMode = true;
			fbBtn.addEventListener(MouseEvent.CLICK, fbBtnClick);

			twBtn.buttonMode = true;
			twBtn.addEventListener(MouseEvent.CLICK, twBtnClick);
			
			

			BtnController.overdown(MovieClip(fbBtn));
			BtnController.overdown(MovieClip(twBtn));
			
		}

		/*
		 * fb 
		 */
		private function fbBtnClick(event : MouseEvent) : void {
			getFbStatus();
		}

		public function getFbStatus() : void {
			ExternalInterface.addCallback("fbLoginComplete", fbLoginComplete);
			ExternalInterface.call("GAME.getLoginStatus");
		}

		private function fbLoginComplete(response : String) : void {
			if (response) {
				dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_FB_LOGIN, true));
			}
		}

		/*
		 * tw
		 */
		private function twBtnClick(event : MouseEvent) : void {
			twLogin();
		}

		public function twLogin() : void {
			ExternalInterface.addCallback("twLoginComplete", twLoginComplete);
			ExternalInterface.call("GAME.twLogin");
		}

		private function twLoginComplete(response : String) : void {
			//if (response) {
				//var obj : Object = JSON.decode(response);
				dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_TW_LOGIN, true));
			//}
		}
	}
}
