package com.framework.system {
	import flash.display.DisplayObject;
	import flash.display.Stage;

	/**
	 * HTML 컨테이너에서 Flash Variables 로 넘겨준 파라미터를 공수한다.
	 * @author kylekaturn (http://kyle-katurn.com)
	 * @class : FlashvarRequester.as
	 * @write_date : 2008. 06. 12
	 * @version : V1.0
	 */
	public class ParameterRequester {
		public static var parameters : Object = new Object();

		/**
		 * flashvar 파라미터 요청
		 * @param referStage	파라미터를 받을 참조 stage 객체
		 * @param paramName		파라미터 네임
		 * @throws	Error
		 */
		public static function request(referStage : Stage, paramName : String) : String {
			if (parameters[paramName]) return parameters[paramName];

			if (referStage.loaderInfo.parameters[paramName] == undefined) {
				throw new Error(paramName + " Flashvar Parameter is not Setted!");
				// return null;
			}

			if (referStage.loaderInfo.parameters[paramName]) {
				return referStage.loaderInfo.parameters[paramName];
			} else {
				return null;
			}
		}

		public static function setParameter(paramName : String, paramValue : String) : void {
			parameters[paramName] = paramValue;
		}
	}
}
