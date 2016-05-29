package com.does.lotte.pacman.steps {
	import com.carlcalderon.arthropod.Debug;
	import com.does.lotte.abstract.InOutMotion;
	import com.does.lotte.controller.BtnController;
	import com.does.lotte.events.InOutMotionEvent;
	import com.does.lotte.events.StepEvent;
	import com.does.lotte.global.GameData;
	import com.does.lotte.global.Score;
	import com.does.lotte.global.Tracking;
	import com.does.lotte.global.User;
	import com.framework.math.MathUtils;

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 * @author chaesumin
	 */
	public class Failed extends InOutMotion {
		public var type1 : Sprite;
		public var type2 : Sprite;
		public var type3 : Sprite;

		public function Failed() {
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
			//level 삭제로 변경. 140522
//			if (User.level == "null") {
//				type1.visible = true;
//				type2.visible = false;
//				type3.visible = false;
//			} else if (User.level == "0") {
//				type1.visible = false;
//				type2.visible = true;
//				type3.visible = false;
//			} else if (User.level == "1") {
				type1.visible = false;
				type2.visible = false;
				type3.visible = true;
//			} else {
//				type1.visible = true;
//				type2.visible = false;
//				type3.visible = false;
//			}

			stop();
		}

		private function start() : void {
			
			gotoAndStop(1);
			//level 삭제로 변경. 140522
//			if (User.level == "1") {
				SendData.load(setScoreComplete);
//			}
			addEventListener(InOutMotionEvent.OUT_MOTION_COMPLETE, outComplete);
		}
		
		private function setScoreComplete() : void {
			var format : TextFormat = new TextFormat();
			format.color = 0xEFFF3D;
			

			if (User.name) {
				var myName : String = User.name;
				var myScore : String = MathUtils.putComma(Score.bestScore);
//				ExternalInterface.call("console.log", "mybestscore:"+Score.bestScore);

				var str1 : String = myName;
				var str2 : String = "님의 최고점수는 ";
				var str3 : String = myScore;
				var str4 : String = "점 입니다.";

				var l1 : int = str1.length;
				var l2 : int = str2.length;
				var l3 : int = str3.length;

				TextField(type3["txt"]).autoSize = TextFieldAutoSize.LEFT;
				TextField(type3["txt"]).text = str1 + str2 + str3 + str4;
				TextField(type3["txt"]).setTextFormat(format, 0, l1);
				TextField(type3["txt"]).setTextFormat(format, l1 + l2, l1 + l2 + l3);
				
				gotoAndPlay(2);
			}
		}

		private function outComplete(event : InOutMotionEvent) : void {
			dispatchEvent(new StepEvent(StepEvent.REPLAY, true));
		}

		override protected function initInMotionScriptComplete() : void {
			MovieClip(type1["replayBtn"]).buttonMode = true;
			MovieClip(type1["replayBtn"]).addEventListener(MouseEvent.CLICK, replayBtnClick);
			MovieClip(type2["replayBtn"]).buttonMode = true;
			MovieClip(type2["replayBtn"]).addEventListener(MouseEvent.CLICK, replayBtnClick);
			MovieClip(type3["replayBtn"]).buttonMode = true;
			MovieClip(type3["replayBtn"]).addEventListener(MouseEvent.CLICK, replayBtnClick);

			MovieClip(type1["loginBtn"]).buttonMode = true;
			MovieClip(type1["loginBtn"]).addEventListener(MouseEvent.CLICK, loginBtnClick);

			BtnController.over(MovieClip(type1["replayBtn"]));
			BtnController.over(MovieClip(type2["replayBtn"]));
			BtnController.over(MovieClip(type3["replayBtn"]));
			BtnController.over(MovieClip(type1["loginBtn"]));
		}

		private function loginBtnClick(event : MouseEvent) : void {
			GameData.goJoin();
		}

		private function replayBtnClick(event : MouseEvent) : void {
			
			Tracking.track("click", "Game_Retry_gameover");
			
			var btn : MovieClip = event.currentTarget as MovieClip;
			btn.buttonMode = false;
			btn.removeEventListener(MouseEvent.CLICK, replayBtnClick);
			
			out();
		}
	}
}
