package com.does.lotte.pacman.steps {
	import flash.external.ExternalInterface;
	import flash.display.MovieClip;

	import com.does.lotte.events.StepEvent;
	import com.greensock.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	/**
	 * @author chaesumin
	 */
	public class EventSubmit extends Sprite {
		public var nameText : TextField;
		public var p1 : TextField;
		public var p2 : TextField;
		public var p3 : TextField;
		public var submitBtn : Sprite;
		public var cancelBtn : Sprite;
		public var xBtn : Sprite;
		public var check1 : MovieClip;
		public var check2 : MovieClip;

		public function EventSubmit() {
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
			thisOut(0);
		}

		private function start() : void {
			submitBtn.buttonMode = true;
			submitBtn.addEventListener(MouseEvent.CLICK, submitBtnClick);

			cancelBtn.buttonMode = true;
			cancelBtn.addEventListener(MouseEvent.CLICK, cancelBtnClick);

			xBtn.buttonMode = true;
			xBtn.addEventListener(MouseEvent.CLICK, xBtnClick);

			check1.buttonMode = true;
			check1.addEventListener(MouseEvent.CLICK, checkClick);
			check2.buttonMode = true;
			check2.addEventListener(MouseEvent.CLICK, checkClick);

			check2.gotoAndStop(2);

			stage.addEventListener(StepEvent.EVENT_SUBMIT, eventSubmitListener);
		}

		private function checkClick(event : MouseEvent) : void {
			if (event.currentTarget == check1) {
				check1.gotoAndStop(2);
				check2.gotoAndStop(1);
			} else {
				check1.gotoAndStop(1);
				check2.gotoAndStop(2);
			}
		}

		private function eventSubmitListener(event : StepEvent) : void {
			thisIn();
		}

		private function xBtnClick(event : MouseEvent) : void {
			thisOut();
		}

		private function cancelBtnClick(event : MouseEvent) : void {
			thisOut();
		}

		private function submitBtnClick(event : MouseEvent) : void {
			var value : String = "y";
			if (check1.currentFrame == 1) {
				value = "n";
			}

			var myName : String = '<input type="text" value="' + nameText.text + '"></input>';
			var ph1 : String = '<input type="text" value="' + p1.text + '"></input>';
			var ph2 : String = '<input type="text" value="' + p2.text + '"></input>';
			var ph3 : String = '<input type="text" value="' + p3.text + '"></input>';
			var radio : String = '<input type="radio" id="game_event_radio" name="game_event_radio" value="' + value + '" />';

			var check : Boolean = ExternalInterface.call("GAME.eventFormCheck", myName, ph1, ph2, ph3, radio);

			if (check) {
				SendData.event(nameText.text, p1.text, p2.text, p3.text, callback);

				function callback(obj : Object) : void {
					// ExternalInterface.call("alert", obj.result);

					SendData.load(thisOut);
				}
			}
		}

		private function thisIn(t : Number = .3) : void {
			mouseChildren = true;
			TweenMax.to(this, t, {autoAlpha:1});

			reset();
		}

		private function reset() : void {
			nameText.text = "";
			p1.text = "";
			p2.text = "";
			p3.text = "";

			check1.gotoAndStop(1);
			check2.gotoAndStop(2);
		}

		private function thisOut(t : Number = .3) : void {
			mouseChildren = false;
			TweenMax.to(this, t, {autoAlpha:0});
		}
	}
}
