package com.does.lotte.pacman.steps {
	import flash.events.MouseEvent;

	import com.does.lotte.abstract.InOutMotion;
	import com.does.lotte.events.GameEvent;
	import com.does.lotte.events.InOutMotionEvent;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.global.User;
	import com.does.lotte.pacman.steps.invite.InviteFriendList;
	import com.does.lotte.pacman.steps.invite.InviteFriendSNS;
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.external.ExternalInterface;

	/**
	 * @author chaesumin
	 */
	public class InviteFriends extends InOutMotion {
		public var sns : InviteFriendSNS;
		public var list : InviteFriendList;
		public var tweet : Sprite;
		public var closeBtn : Sprite;
		private var isClose : Boolean;

		public function InviteFriends() {
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
			removeEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
			removeEventListener(GameEvent.INVITE_FRIEND_COMPLETE, inviteFriendComplete);
			removeEventListener(GameEvent.INVITE_FRIEND_FB_LOGIN, inviteFriendFbLogin);
			removeEventListener(GameEvent.INVITE_FRIEND_TW_LOGIN, inviteFriendTwLogin);
		}

		private function init() : void {
			setObjectAlpha(null, 0);
		}

		private function start() : void {
			addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
			addEventListener(GameEvent.INVITE_FRIEND_COMPLETE, inviteFriendComplete);
			addEventListener(GameEvent.INVITE_FRIEND_FB_LOGIN, inviteFriendFbLogin);
			addEventListener(GameEvent.INVITE_FRIEND_TW_LOGIN, inviteFriendTwLogin);
		}

		private function inviteFriendTwLogin(event : GameEvent) : void {
			setObjectAlpha(tweet, .3);
			// ExternalInterface.call("GAME.getFriends");
		}

		private function inviteFriendFbLogin(event : GameEvent) : void {
			setObjectAlpha(list, .3);
			ExternalInterface.call("GAME.getFriends");
		}

		private function inviteFriendComplete(event : GameEvent) : void {
			setObjectAlpha(null, .3);
			TweenMax.delayedCall(.6, out);
		}

		private function outComplete(event : InOutMotionEvent) : void {
			if (isClose) {
				dispatchEvent(new StepEvent(StepEvent.ROULETTE_FIRST, true));
			} else {
				dispatchEvent(new StepEvent(StepEvent.ROULETTE_START, true));
			}
			
			
		}

		override protected function initInMotionScriptComplete() : void {
			if (User.type == "fb") {
				// sns.getFbStatus();
				dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_FB_LOGIN, true));
			} else if (User.type == "tw") {
				// sns.twLogin();
				dispatchEvent(new GameEvent(GameEvent.INVITE_FRIEND_TW_LOGIN, true));
			} else {
				setObjectAlpha(sns, .3);
			}

			// closeBtn.buttonMode = true;
			// closeBtn.addEventListener(MouseEvent.CLICK, closeBtnClick);
		}

		private function closeBtnClick(event : MouseEvent) : void {
			isClose = true;
			inviteFriendComplete(null);
		}

		private function setObjectAlpha(obj : Sprite, time : Number = .3) : void {
			TweenMax.to(sns, time, {autoAlpha:0});
			TweenMax.to(list, time, {autoAlpha:0});
			TweenMax.to(tweet, time, {autoAlpha:0});

			if (obj) TweenMax.to(obj, time, {autoAlpha:1, delay:time});
		}
	}
}
