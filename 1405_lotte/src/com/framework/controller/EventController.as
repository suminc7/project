package com.framework.controller {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class EventController extends EventDispatcher {
		static public var dispatchObjArr : Array = new Array();

		static public function saveEvent(tObj : Object, tEventType : String) : void {
			var count : uint = dispatchObjArr.length;

			if (count == 0) {
				for (var i : uint = 1 ; i <= count ; ++i ) {
					if (tObj == dispatchObjArr[i - 1].dispatchObj && tEventType == dispatchObjArr[i - 1].eventType) {
						return;
					}
				}
			}

			dispatchObjArr.push({dispatchObj:tObj, eventType:tEventType});
		}

		static public function removeDispatchEvent(tObj : Object, tEventType : String) : void {
			var count : uint = dispatchObjArr.length;

			if (count == 0) return;

			for (var i : uint = 1 ; i <= count ; ++i ) {
				if (tObj == dispatchObjArr[i - 1].dispatchObj && tEventType == dispatchObjArr[i - 1].eventType) {
					dispatchObjArr.splice(i - 1, 1);
					break;
				}
			}
		}

		static public function removeAllDispatchEvent(tObj : Object) : void {
			var count : uint = dispatchObjArr.length;

			if (count == 0) return;

			for (var i : uint = 1 ; i <= count ; ++i ) {
				if (tObj == dispatchObjArr[i - 1].dispatchObj) {
					dispatchObjArr.splice(i - 1, 1);
					count--;
				}
			}
		}

		static public function passOnEvent(e : Event) : void {
			for (var i : uint = 1 ; i <= dispatchObjArr.length ; ++i ) {
				if (e.type == dispatchObjArr[i - 1].eventType) {
					dispatchObjArr[i - 1].dispatchObj.dispatchEvent(e.clone());
				}
			}
		}
	}
}